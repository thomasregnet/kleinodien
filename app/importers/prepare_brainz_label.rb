# frozen_string_literal: true

# Find a Company in the database or get it from MusicBrainz
class PrepareBrainzLabel < PrepareBrainzBase
  def initialize(stub:, **args)
    super(args)
    @code = stub.brainz_code
    @stub = stub
  end

  private

  attr_reader :code, :stub

  def prepare
    return if proxy.cached?(:label, code)
    return if Company.find_by(brainz_code: code)
    return if FindByCodesService.call(
      model_class: Company,
      codes_hash:  blueprint.codes_hash
    )

    area_blueprint = blueprint.area || return

    prepare_area(stub: area_blueprint)
  end

  def blueprint
    @blueprint ||= proxy.get(:label, code)
  end
end
