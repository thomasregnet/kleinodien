# frozen_string_literal: true

require 'test_data/path_service'

# Proxy for testing
class FakeProxy
  def initialize
    @cache          = {}
    @fetch_requests = 0
    @get_calls      = 0
    @locked         = false
  end

  attr_reader :cache, :fetch_requests, :get_calls, :locked

  def cached?(what, code)
    cache.key?(uri_for(what, code))
  end

  def get(what, code)
    @get_calls += 1

    uri = uri_for(what, code)

    blueprint = cache[uri]
    return blueprint if blueprint

    path = uri.sub(%r{\A.+\/\/}, '')
    xml = TestData::PathService.call(path: path)
    blueprint = BrainzBlueprint.from_xml(xml)
    cache[uri] = blueprint

    blueprint
  end

  def cache_size
    cache.length
  end

  def matches(regexp)
    cache.keys.count { |key| key.match(regexp) }
  end

  def called_get?
    return true if get_calls.positive?
  end

  def lock
    @locked = true
  end

  def locked?
    locked
  end

  # This method smells of :reek:FeatureEnvy
  def requested_for?(regexp, expected_count = nil)
    count = cache.keys.count { |key| key.match(regexp) }

    return true if count.positive? && !expected_count

    count == expected_count
  end

  private

  def request_class_for(what)
    "Brainz#{what.to_s.camelize}ImportRequest".constantize
  end

  def uri_for(what, code)
    request_class_for(what).to_uri(code: code)
  end
end

