module BrainzCacheKey
  def cache_key
    "#{kind}/#{code}#{query_string}"
  end
end 
