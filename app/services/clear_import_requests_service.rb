class ClearImportRequestsService
  include CallWithArgs
  include ImportStoreCommons
  # include ImportStoreRequestsAndUrisKey
  include ImportQueuesConsumption

  private

  attr_reader :importer_name

  def initialize(args)
    @importer_name = args[:importer_name]
  end

  def private_call
    # import_store.del(requests_key)
    # import_store.del(uris_key)
    import_requests.clear
    import_uris.clear
  end
end
