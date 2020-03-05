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

  def matches(regexp)
    cache.keys.count { |key| key.match(regexp) }
  end

  # rubocop:disable Naming/PredicateName
  def has_received_get?
    return true if get_calls.positive?
  end
  # rubocop:enable Naming/PredicateName

  private

  def import_request_for(what, code)
    request_class = request_class_for(what)
    request_class.create!(
      code:         code,
      import_order: import_order
    )
  end

  def request_class_for(what)
    "Brainz#{what.to_s.camelize}ImportRequest".constantize
  end

  def uri_for(what, code)
    request_class_for(what).to_uri(code: code)
  end
end

