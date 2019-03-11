# frozen_string_literal: true

# Fetch data and store it to the cache
class FetchDataService < ServiceBase
  include ImportCacheConsumption
  include ImportQueuesConsumption

  def initialize(args)
    @importer_name = args[:importer_name]
  end

  attr_reader :importer_name

  def call
    fetch unless import_uris.empty?
  end

  def fetch
    uri = import_uris.peek
    response = Faraday.get(uri)
    store_and_pop(uri, response) if response.status == 200
    SuspendFetchingService.call(response: response)
  end

  def store_and_pop(uri, response)
    import_cache.store(uri, response.body)
    import_uris.deq
  end

  def any_uris?
    !import_uris.empty?
  end
end
