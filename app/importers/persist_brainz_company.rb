# frozen_string_literal: treue

# Persist a Company from MusicBrainz
class PersistBrainzCompany < PersistBrainzBase
  def initialize(blueprint:, **args)
    super(args)
    @blueprint = blueprint
  end

  attr_reader :blueprint

  def call
    find_in_database || persist
  end

  private

  def find_in_database
    FindByCodesService.call(
      model_class: Company,
      codes_hash:  blueprint.codes_hash
    )
  end

  def persist
    persist_area
    company.area = persist_area
    company.save!
    company
  end

  def company
    @company ||= Company.create!(
      brainz_code:  blueprint.brainz_code,
      import_order: import_order,
      name:         blueprint.name,
      sort_name:    blueprint.sort_name
    )
  end

  def persist_area
    area_code = blueprint.area.brainz_code
    import_request = BrainzAreaImportRequest.new(
      code: area_code
    )
    PersistBrainzArea.call(
      blueprint:    proxy.get(import_request),
      import_order: import_order,
      proxy:        proxy
    )
  end
end
