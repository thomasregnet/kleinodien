class ClearImportRequestsService
  include CallWithArgs
  include ImportStoreCommons
  include ImportQueuesConsumption

  private

  attr_reader :importer_name

  def initialize(args)
    @importer_name = args[:importer_name]
  end

  def private_call
    import_requests.clear
    import_uris.clear
  end
end
