# Store key and value to redis using a expiration
class ImportCacheStoreService
  include ImportCacheKey
  include ImportStore

  DEFAULT_TIMEOUT_SECONDS = 3_600

  # TODO: make the default timeout configurable
  def self.call(key, value, expire = DEFAULT_TIMEOUT_SECONDS)
    import_store.set(cache_key(key), value, ex: expire)
  end
end
