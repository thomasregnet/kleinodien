# frozen_string_literal: true

# Persist a CompilationRelease using data retrieved from MusicBrainz
class PersistBrainzRelease < PersistBrainzBase
  def initialize(args)
    super(args)
    @import_request = args[:import_request]
  end

  attr_reader :import_request

  def call
    find_already_existing || persist
  end

  def blueprint
    proxy.get(import_request)
  end

  def find_already_existing
    FindByCodesService.call(
      codes_hash:  blueprint.codes_hash,
      model_class: Release
    )
  end

  def persist
    release = Release.create!(
      artist_credit: persist_artist_credit,
      head:          persist_release_head,
      title:         blueprint.title,
      type:          type
    )
    persist_media(release)
    persist_subsets(release)
    release
  end

  def persist_artist_credit
    PersistBrainzArtistCredit.call(
      blueprint: blueprint.artist_credit,
      proxy:     proxy
    )
  end

  def persist_release_head
    import_request = BrainzReleaseGroupImportRequest.new(
      code: blueprint.release_group.brainz_code
    )

    PersistBrainzReleaseHead.call(
      # blueprint: proxy.get(import_request),
      import_request: import_request,
      proxy:          proxy
    )
  end

  # This method smells of :reek:FeatureEnvy
  def persist_media(release)
    reduced_media.each.with_index(1) do |release_medium, position|
      release.media.create!(
        format:   release_medium[:medium_format],
        position: position,
        quantity: release_medium[:quantity]
      )
    end
  end

  def persist_subsets(release)
    blueprint.media.each do |medium|
      PersistBrainzHeapSubset.call(
        blueprint: medium,
        release:   release,
        # heap:      release,
        proxy:     proxy
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
    ChooseBrainzReleaseTypeService.call(brainz_type: blueprint.release_group.type)
  end
end
