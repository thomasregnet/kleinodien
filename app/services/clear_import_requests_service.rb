class ClearImportRequestsService
  include CallWithArgs
  include ImportStoreCommons

  private

  attr_reader :importer_name

  def initialize(args)
    @importer_name = args[:importer_name]
  end

  def private_call
    import_store.del(requests_key)
    import_store.del(uris_key)
  end

  def requests_key
    "#{importer_name}:requests"
  end

  def uris_key
    "#{importer_name}:uris"
  end
end
