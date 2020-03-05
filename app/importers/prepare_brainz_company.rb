# frozen_string_literal: true

# Find a Company in the database or get it from MusicBrainz
class PrepareBrainzCompany < PrepareBrainzBase
  def initialize(blueprint:, **args)
    super(args)
    @brainz_code = blueprint.brainz_code
  end

  private

  attr_reader :brainz_code

  def prepare
    return if proxy.cached?(:company, brainz_code)
    return if Company.find_by(brainz_code: brainz_code)
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
      blueprint:    blueprint.area,
      import_order: import_order,
      proxy:        proxy
    )
  end

  def blueprint
    @blueprint ||= proxy.get(:company, brainz_code)
  end
end
