# returns cached data
class ImportCacheFetchService
  include ImportCacheKey
  include ImportStore

  def self.call(key)
    import_store.get(cache_key(key))
  end
end
