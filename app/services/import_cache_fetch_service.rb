# returns cached data
class ImportCacheFetchService
  include CallWithArgs
  include ImportStoreCommons

  private

  attr_reader :key

  def initialize(key)
    @key = key
  end

  def private_call
    cache_key = cache_key_for(key)
    import_store.get(cache_key)
  end
end
