module BrainzCacheKey
  def to_key
    "#{kind}/#{code}#{query_string}"
  end
end 
