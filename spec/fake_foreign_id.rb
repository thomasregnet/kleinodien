# Fake a ForeignId class for testing
class FakeForeignId
  CACHE_KEY = 'fake/cache?key'.freeze
  attr_reader :code

  def initialize(args)
    @code = args[:code]
  end

  def to_key
    CACHE_KEY
  end
end
