module RedisCache
  extend ActiveSupport::Concern

  CACHE_PREFIX = 'cache:'.freeze
  DEFAULT_EXPIRE = 3600

  included do
    define_singleton_method(:redis) do |redis|
      define_method(:redis) { redis }
    end
  end

  def fetch(key)
    redis.get(cache_key_for(key))
  end

  def store(key, value, expires = DEFAULT_EXPIRE)
    redis.set(cache_key_for(key), value, ex: expires)
  end

  def cache_key_for(key)
    "#{CACHE_PREFIX}#{key}"
  end
end
