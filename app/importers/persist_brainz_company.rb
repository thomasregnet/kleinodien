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
    Company.create!(
      import_order: import_order,
      name:         blueprint.name,
      sort_name:    blueprint.sort_name
    )
  end
end
