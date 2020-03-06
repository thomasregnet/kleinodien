# frozen_string_literal: true

# Prepare a MusicBrainz release for import
class PrepareBrainzRelease < PrepareBrainzBase
  def initialize(stub:, **args)
    super(args)
    @code = stub.brainz_code
    @stub = stub
  end

  attr_reader :code, :stub

  private

  def prepare
    # return if proxy.cached?(:release, blueprint.brainz_code)
    return if Release.find_by(brainz_code: code)
    return if FindByCodesService.call(
      model_class: Release,
      codes_hash:  blueprint.codes_hash
    )

    prepare_siblings
  end

  def blueprint
    @blueprint ||= proxy.get(:release, code)
  end

  def prepare_siblings
    prepare_artist_credit  || return
    prepare_companies      || return
    prepare_release_group  || return
    prepare_release_events || return
    prepare_media          || return
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
        import_order: import_order,
        proxy:        proxy,
        stub:         label_info.label
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
      PrepareBrainzRecording.call(
        import_order: import_order,
        proxy:        proxy,
        stub:         track.recording
      )
    end
  end

  def prepare_release_events
    blueprint.release_events.each do |release_event|
      PrepareBrainzReleaseEvent.call(
        blueprint:    release_event,
        import_order: import_order,
        proxy:        proxy
      )
    end
  end

  def prepare_release_group
    PrepareBrainzReleaseGroup.call(
      import_order: import_order,
      proxy:        proxy,
      stub:         blueprint.release_group
    )
  end

  def find_already_existing
    FindByCodesService.call(
      model_class: Release,
      codes_hash:  blueprint.codes_hash
    )
  end
end
