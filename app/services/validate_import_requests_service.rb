class ValidateImportRequestsService < ServiceBase
  include ImportQueuesConsumption

  def initialize(args)
    @importer_name = args[:importer_name]
  end

  attr_reader :importer_name

  def call
    return true unless import_uris.length.positive?
    return true if import_requests.length.positive?

    false
  end
end
