# frozen_string_literal: true

# Find a Company in the database or get it from MusicBrainz
class PrepareBrainzCompany < PrepareBrainzBase
  def initialize(blueprint:, **args)
    super(args)
    @brainz_code = blueprint.brainz_code
  end

  private

  attr_reader :blueprint, :brainz_code

  def prepare
    find_in_database && return

    trigger_proxy
    prepare_area
  end

  def find_in_database
    Company.find_by(brainz_code: brainz_code)
  end

  def prepare_area
    PrepareBrainzArea.call(
      blueprint:    blueprint.area,
      import_order: import_order,
      proxy:        proxy
    )
  end

  def trigger_proxy
    @blueprint = proxy.get(:company, brainz_code)
  end
end
