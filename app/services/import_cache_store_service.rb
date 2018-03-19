# Store key and value to redis using a expiration
class ImportCacheStoreService
  include ImportStoreCommons

  DEFAULT_EXPIRE_SECONDS = 3_600

  def self.call(key, value, expire = DEFAULT_EXPIRE_SECONDS)
    new(key, value, expire).call
  end

  attr_reader :key, :value, :expire

  def initialize(key, value, expire)
    @key    = key
    @value  = value
    @expire = expire
  end

  def call
    cache_key = cache_key_for(key)
    import_store.set(cache_key, value, ex: expire)
  end
end
