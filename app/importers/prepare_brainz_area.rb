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
  end

  def trigger_proxy
    import_request = BrainzAreaImportRequest.create!(
      code:         blueprint.brainz_code,
      import_order: import_order
    )
    proxy.get(import_request)
  end
end
