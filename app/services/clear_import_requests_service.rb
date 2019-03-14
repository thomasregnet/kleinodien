class ClearImportRequestsService < ServiceBase
  include ImportStoreCommons
  include ImportQueuesConsumption

  def initialize(args)
    @importer_name = args[:importer_name]
  end

  attr_reader :importer_name

  def call
    import_requests.clear
    import_uris.clear
  end
end
