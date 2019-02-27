# frozen_string_literal: true

# Prepare a MusicBrainz release for import
class PrepareBrainzRelease < PrepareBrainzBase
  def initialize(args)
    super(args)
    @blueprint = args[:blueprint]
  end

  attr_reader :blueprint

  def call
    heap = find_already_existing
    return heap if heap

    prepare_artist_credit
    prepare_release_group
    prepare_media

    nil
  end

  def prepare_artist_credit
    PrepareBrainzArtistCredit.call(
      blueprint: blueprint.artist_credit,
      proxy:     proxy
    )
  end

  def prepare_media
    blueprint.media.each do |medium|
      prepare_recordings(medium)
    end
  end

  def prepare_recordings(medium)
    # medium.track_list.track.each do |track|
    tracklist(medium).each do |track|
      import_request = BrainzRecordingImportRequest.new(
        code: track.recording.brainz_code
      )

      PrepareBrainzRecording.call(
        import_request: import_request,
        proxy:          proxy
      )
    end
  end

  def prepare_release_group
    PrepareBrainzReleaseGroup.call(
      import_request: release_group_import_request,
      proxy:          proxy
    )
  end

  def release_group_import_request
    BrainzReleaseGroupImportRequest.new(
      code: blueprint.release_group.brainz_code
    )
  end

  def find_already_existing
    FindByCodesService.call(
      model_class: Heap,
      codes_hash:  blueprint.codes_hash
    )
  end

  def tracklist(medium)
    FlattenBrainzTrackListService.call(blueprint: medium)
  end
end
