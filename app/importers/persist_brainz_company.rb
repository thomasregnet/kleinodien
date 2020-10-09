# frozen_string_literal: true

# Persist a Company from MusicBrainz
class PersistBrainzCompany < PersistBrainzBase
  def initialize(code:, name: nil, **args)
    super(args)
    @code = code
    @name = name
  end

  attr_reader :code, :name

  def call
    find_in_database || persist
  end

  private

  def blueprint
    @blueprint ||= proxy.get(:label, code)
  end

  def find_in_database
    Company.find_by(brainz_code: code) || Company.find_by(name: name)
  end

  def persist
    company.area = persist_area(code: blueprint.area.brainz_code, name: blueprint.area.name)
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
end
