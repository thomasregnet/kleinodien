# Fetch data and store it to the cache
class FetchDataService
  include CallWithArgs
  include ImportStoreCommons
  include ImportStoreRequestsAndUrisKey

  private

  attr_reader :importer_name

  def initialize(args)
    @importer_name = args[:importer_name]
  end

  def private_call
    return false unless any_uris?
    fetch while any_uris?
  end

  def fetch
    uri = import_store.lindex(uris_key, 0)
    response = Faraday.get(uri)
    store_and_pop(uri, response) if response.status == 200
    suspend_fetching(response)
  end

  def suspend_fetching(response)
    SuspendFetchingService.call(response: response)
  end

  def store_and_pop(uri, response)
    ImportCacheStoreService.call(uri, response.body)
    import_store.lpop(uris_key)
  end

  def any_uris?
    return false unless import_store.llen(uris_key).positive?
    true
  end
end
