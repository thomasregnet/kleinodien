# frozen_string_literal: true

# Prepare a MusicBrainz release for import
class PrepareBrainzRelease < PrepareBrainzBase
  def initialize(blueprint:, **args)
    super(args)
    @blueprint = blueprint
  end

  attr_reader :blueprint

  private

  # This method smells of :reek:TooManyStatements
  def prepare
    release = find_already_existing
    return release if release

    prepare_artist_credit  || return
    prepare_companies      || return
    prepare_release_group  || return
    prepare_release_events || return
    prepare_media          || return

    true
  end

  public

  def prepare_artist_credit
    PrepareBrainzArtistCredit.call(
      blueprint:    blueprint.artist_credit,
      import_order: import_order,
      proxy:        proxy
    )
  end

  def prepare_companies
    blueprint.label_infos.each do |label_info|
      PrepareBrainzCompany.call(
        blueprint:    label_info.label,
        import_order: import_order,
        proxy:        proxy
      )
    end
  end

  def prepare_media
    blueprint.media.each do |medium|
      prepare_recordings(medium)
    end
  end

  def prepare_recordings(medium)
    medium.flat_track_list.each do |track|
      import_request = BrainzRecordingImportRequest.new(
        code: track.recording.brainz_code
      )

      PrepareBrainzRecording.call(
        import_order:   import_order,
        import_request: import_request,
        proxy:          proxy
      )
    end
  end

  def prepare_release_events
    blueprint.release_events.each do |release_event_blueprint|
      PrepareBrainzReleaseEvent.call(
        blueprint:    release_event_blueprint,
        import_order: import_order,
        proxy:        proxy
      )
    end
  end

  def prepare_release_group
    PrepareBrainzReleaseGroup.call(
      import_order:   import_order,
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
      model_class: Release,
      codes_hash:  blueprint.codes_hash
    )
  end
end
