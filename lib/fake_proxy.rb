# frozen_string_literal: true

require 'test_data/path_service'

# Proxy for testing
class FakeProxy
  def initialize
    @cache          = {}
    @fetch_requests = 0
    @get_calls      = 0
  end

  attr_reader :cache, :fetch_requests, :get_calls

  def get(key)
    @get_calls += 1

    cache[key] || from_test_data(key)
    path = key.to_uri.sub(%r{\A.+\/\/}, '')
    raw = TestData::PathService.call(path: path)
    BrainzBlueprint.from_xml(raw)
  end

  # This method smells of :reek:ToManyStatements
  def from_test_data(key)
    @fetch_requests += 1

    uri = key.to_uri
    path = uri.sub(%r{\A.+\/\/}, '')
    raw = TestData::PathService.call(path: path)
    blueprint = BrainzBlueprint.from_xml(raw)

    cache[uri] = blueprint

    blueprint
  end

  def cache_size
    cache.length
  end

  def match(regexp)
    cache.keys.count { |key| key.match(regexp) }
  end
end

