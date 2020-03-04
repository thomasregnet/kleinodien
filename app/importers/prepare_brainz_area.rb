# frozen_string_literal: true

# Prepare an Area
class PrepareBrainzArea < PrepareBrainzBase
  def initialize(blueprint:, **args)
    super(args)
    @blueprint = blueprint
  end

  attr_reader :blueprint

  def prepare
    find_already_existing || trigger_proxy
  end

  def find_already_existing
    find_by_brainz_code || find_by_name
  end

  def find_by_brainz_code
    Area.find_by(brainz_code: blueprint.brainz_code)
  end

  def find_by_name
    Area.find_by(name: blueprint.name)
  end

  def trigger_proxy
    # import_request = BrainzAreaImportRequest.create!(
    #   code:         blueprint.brainz_code,
    #   import_order: import_order
    # )
    # proxy.get(import_request)
    proxy.new_get(:area, blueprint.brainz_code)
  end
end
