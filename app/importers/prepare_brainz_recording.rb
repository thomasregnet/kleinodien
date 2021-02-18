# frozen_string_literal: true

# Prepares a MusicBrainz Recording for import.
class PrepareBrainzRecording < PrepareBrainzBase
  def initialize(stub:, **args)
    super(**args)
    @code = stub.brainz_code
    @stub = stub
  end

  attr_reader :code, :stub

  private

  def blueprint
    @blueprint = proxy.get(:recording, code)
  end

  def prepare
    return if proxy.cached?(:recording, code)
    return if Artist.find_by(brainz_code: code)
    return if FindByCodesService.call(
      model_class: Piece,
      codes_hash:  blueprint.codes_hash
    )

    prepare_artist_credit(blueprint: blueprint.artist_credit)
  end
end
