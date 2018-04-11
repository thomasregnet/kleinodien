module RedisCache
  extend ActiveSupport::Concern
  # include ImportStore

  CACHE_PREFIX = 'cache:'.freeze
  DEFAULT_EXPIRE = 3600

  included do
    define_singleton_method(:redis) do |redis|
      define_method(:redis) { redis }
    end
  end

  def fetch(key)
    import_store.get(cache_key_for(key))
  end

  def store(key, value, expires = DEFAULT_EXPIRE)
    import_store.set(cache_key_for(key), value, ex: expires)
  end

  def cache_key_for(key)
    "#{CACHE_PREFIX}#{key}"
  end
end
