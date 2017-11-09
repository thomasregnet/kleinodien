# Fake a Reference class for testing
class FakeReference
  CACHE_KEY = 'fake/cache?key'.freeze
  attr_reader :code

  def initialize(args)
    @code = args[:code]
  end

  def to_key
    CACHE_KEY
  end
end
