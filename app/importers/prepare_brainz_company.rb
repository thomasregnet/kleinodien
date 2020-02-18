# frozen_string_literal: true

# Find a Company in the database or get it from MusicBrainz
class PrepareBrainzCompany < PrepareBrainzBase
  def initialize(blueprint:, **args)
    super(args)
    @blueprint = blueprint
  end

  private

  attr_reader :blueprint

  def prepare
    find_in_database || trigger_proxy
  end

  def find_in_database
    Company.find_by(brainz_code: blueprint.brainz_code)
  end

  def trigger_proxy
    import_request = BrainzCompanyImportRequest.new(code: blueprint.brainz_code)
    proxy.get(import_request)
  end
end
