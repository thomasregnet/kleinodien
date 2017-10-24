module BrainzCacheKey
  def cache_key
    "#{kind}/#{value}#{query_string}"
  end
end 
