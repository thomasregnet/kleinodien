# Fake a Reference class for testing
class FakeReference
  CACHE_KEY = 'fake/cache?key'.freeze
  attr_reader :code

  def self.from_code(code)
    new(code: code)
  end

  def initialize(args)
    @code = args[:code]
  end

  def to_key
    CACHE_KEY
  end

  def to_uri
    "https>//fake/#{code}"
  end

  def category
    :fake_catagory
  end
end
