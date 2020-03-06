# frozen_string_literal: true

# Find a Company in the database or get it from MusicBrainz
class PrepareBrainzCompany < PrepareBrainzBase
  def initialize(stub:, **args)
    super(args)
    @code = stub.brainz_code
    @stub = stub
  end

  private

  attr_reader :code, :stub

  def prepare
    return if proxy.cached?(:company, code)
    return if Company.find_by(brainz_code: code)
    return if FindByCodesService.call(
      model_class: Company,
      codes_hash:  blueprint.codes_hash
    )

    prepare_siblings
  end

  def prepare_siblings
    prepare_area
  end

  def prepare_area
    PrepareBrainzArea.call(
      import_order: import_order,
      proxy:        proxy,
      stub:         blueprint.area
    )
  end

  def blueprint
    @blueprint ||= proxy.get(:company, code)
  end
end
