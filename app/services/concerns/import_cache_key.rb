# Provides the method cache_key
module ImportCacheKey
  extend ActiveSupport::Concern

  module ClassMethods
    def cache_key(key)
      "cache:#{key}"
    end
  end
end
