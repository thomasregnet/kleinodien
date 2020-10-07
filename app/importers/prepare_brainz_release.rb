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
    return if Release.find_by(brainz_code: code)
    return if FindByCodesService.call(
      model_class: Release,
      codes_hash:  blueprint.codes_hash
    )

    Rails.logger.info("Preparing Brainz Release #{code}")
    prepare_siblings
  end

  def blueprint
    @blueprint ||= proxy.get(:release, code)
  end

  def prepare_siblings
    prepare_artist_credit(blueprint: blueprint.artist_credit)
    prepare_companies
    prepare_release_group(stub: blueprint.release_group)
    prepare_release_events
    prepare_media
  end

  public

  def prepare_companies
    blueprint.label_infos.each do |label_info|
      prepare_label(stub: label_info.label)
    end
  end

  def prepare_media
    blueprint.media.each do |medium|
      prepare_recordings(medium)
    end
  end

  def prepare_recordings(medium)
    medium.flat_track_list.each do |track|
      prepare_recording(stub: track.recording)
    end
  end

  def prepare_release_events
    blueprint.release_events.each do |release_event|
      prepare_release_event(blueprint: release_event)
    end
  end
end
