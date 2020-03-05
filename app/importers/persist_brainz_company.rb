# frozen_string_literal: treue

# Persist a Company from MusicBrainz
class PersistBrainzCompany < PersistBrainzBase
  def initialize(blueprint:, **args)
    super(args)
    @code = blueprint.brainz_code
  end

  attr_reader :code

  def call
    find_in_database || persist
  end

  private

  def blueprint
    @blueprint ||= proxy.new_get(:company, code)
  end

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
    PersistBrainzArea.call(
      blueprint:    blueprint.area,
      import_order: import_order,
      proxy:        proxy
    )
  end
end
