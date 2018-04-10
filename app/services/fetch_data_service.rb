# Fetch data and store it to the cache
class FetchDataService
  include CallWithArgs
  include ImportQueuesConsumption
  include ImportStoreRequestsAndUrisKey

  private

  attr_reader :importer_name

  def initialize(args)
    @importer_name = args[:importer_name]
  end

  def private_call
    fetch unless import_uris.empty?
  end

  def fetch
    uri = import_uris.peek
    response = Faraday.get(uri)
    store_and_pop(uri, response) if response.status == 200
    suspend_fetching(response)
  end

  def suspend_fetching(response)
    SuspendFetchingService.call(response: response)
  end

  def store_and_pop(uri, response)
    ImportCacheStoreService.call(uri, response.body)
    import_uris.deq
  end

  def any_uris?
    !import_uris.empty?
  end
end
