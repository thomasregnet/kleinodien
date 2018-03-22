class ClearImportRequestsService
  include CallWithArgs
  include ImportStoreCommons
  include ImportStoreRequestsAndUrisKey

  private

  attr_reader :importer_name

  def initialize(args)
    @importer_name = args[:importer_name]
  end

  def private_call
    import_store.del(requests_key)
    import_store.del(uris_key)
  end
end
