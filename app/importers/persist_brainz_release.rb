# frozen_string_literal: true

# Persist a CompilationRelease using data retrieved from MusicBrainz
class PersistBrainzRelease < PersistBrainzBase
  def initialize(blueprint:, **args)
    super(args)
    @blueprint = blueprint
  end

  # attr_reader :import_request
  attr_reader :blueprint

  def call
    find_already_existing || persist
  end

  def find_already_existing
    FindByCodesService.call(
      codes_hash:  blueprint.codes_hash,
      model_class: Release
    )
  end

  def persist
    persist_media
    persist_subsets
    persist_release_events
    # add_area must be called after persist_release_events
    add_area

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

  def persist_artist_credit
    PersistBrainzArtistCredit.call(
      blueprint:    blueprint.artist_credit,
      import_order: import_order,
      proxy:        proxy
    )
  end

  def release
    @release ||= Release.create!(
      artist_credit: persist_artist_credit,
      head:          persist_release_head,
      import_order:  import_order,
      language:      language,
      # TODO: import script of a release
      # script:        script,
      title:         blueprint.title,
      type:          type
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

  def persist_release_events
    blueprint.release_events.each do |release_event|
      PersistBrainzReleaseEvent.call(
        blueprint:    release_event,
        import_order: import_order,
        proxy:        proxy,
        release:      release
      )
    end
  end

  def persist_release_head
    import_request = BrainzReleaseGroupImportRequest.new(
      code: blueprint.release_group.brainz_code
    )

    PersistBrainzReleaseHead.call(
      import_request: import_request,
      import_order:   import_order,
      proxy:          proxy
    )
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
      PersistBrainzReleaseSubset.call(
        blueprint:    medium,
        import_order: import_order,
        release:      release,
        proxy:        proxy
      )
    end
  end

  def reduced_media
    ReduceBrainzReleaseMediaService.call(
      blueprint:    blueprint.media,
      import_order: import_order
    )
  end

  def type
    ChooseBrainzReleaseTypeService.call(
      brainz_type: blueprint.release_group.type
    )
  end
end
