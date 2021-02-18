# frozen_string_literal: true

# Persist a CompilationRelease using data retrieved from MusicBrainz
class PersistBrainzRelease < PersistBrainzBase
  def initialize(code:, **args)
    super(**args)
    # @blueprint = blueprint
    @code = code
  end

  # attr_reader :import_request
  attr_reader :code

  def call
    find_already_existing || persist
  end

  def blueprint
    @blueprint ||= proxy.get(:release, code)
  end

  def find_already_existing
    FindByCodesService.call(
      codes_hash:  blueprint.codes_hash,
      model_class: Release
    )
  end

  # This method smells of :reek:TooManySatements
  def persist
    persist_media
    persist_subsets
    persist_release_events
    persist_release_companies
    # add_area must be called after persist_release_events
    add_area

    import_order.create_cover_art_release_import_order!(code: code, user: import_order.user)

    release
  end

  # #add_area must be called after the release events are persisted.
  # The release_events set their areas. #add_area "hopes" that the
  # required Area is beneath the release_event-areas.
  def add_area
    iso_3166_1_code = blueprint.country || return
    area = Area.joins(:iso3166_part1_countries)
               .where(iso3166_part1_countries: { code: iso_3166_1_code })
               .limit(1).first

    release.area = area
    release.save!
  end

  def release
    @release ||= Release.create!(release_arguments)
  end

  # rubocop:disable Metrics/MethodLength
  def release_arguments
    artist_credit = persist_artist_credit(blueprint: blueprint.artist_credit)
    arguments = {
      artist_credit: artist_credit,
      head:          release_head,
      import_order:  import_order,
      language:      language,
      script:        script,
      title:         blueprint.title,
      type:          type
    }

    CodesForModelService.call(
      model_class: Release,
      codes_hash:  blueprint.codes_hash,
      given:       arguments
    )
  end
  # rubocop:enable Metrics/MethodLength

  def release_head
    @release_head ||= persist_release_head(
      code: blueprint.release_group.brainz_code
    )
  end

  # This method smells of :reek:FeatureEnvy
  def language
    iso_code_3 = blueprint.text_representation.language
    Language.find_or_create_by(iso_code_3: iso_code_3) do |language|
      language.name       = iso_code_3
      language.iso_code_3 = iso_code_3
    end
  end

  def persist_release_companies
    blueprint.label_infos.each do |label_info|
      persist_release_company(blueprint: label_info, release: release)
    end
  end

  def persist_release_events
    blueprint.release_events.each do |release_event|
      persist_release_event(blueprint: release_event, release: release)
    end
  end

  def persist_media
    reduced_media.each.with_index(1) do |release_medium, position|
      release.media.create!(
        format:   release_medium[:medium_format],
        position: position,
        quantity: release_medium[:quantity]
      )
    end
  end

  def persist_subsets
    blueprint.media.each do |medium|
      persist_release_subset(blueprint: medium, release: release)
    end
  end

  def reduced_media
    ReduceBrainzReleaseMediaService.call(
      blueprint:    blueprint.media,
      import_order: import_order
    )
  end

  # This method smells of :reek:FeatureEnvy
  def script
    iso_code = blueprint.text_representation.script
    Script.find_or_create_by(iso_code: iso_code) do |script|
      script.iso_code = iso_code
      script.name     = iso_code
    end
  end

  def type
    ChooseBrainzReleaseTypeService.call(
      brainz_type: blueprint.release_group.type
    )
  end
end
