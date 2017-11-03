# Fake a ForeignId class for testing
class FakeForeignId
  CACHE_KEY = 'fake/cache?key'.freeze
  attr_reader :value

  def initialize(args)
    @value = args[:value]
  end

  def cache_key
    CACHE_KEY
  end
end
