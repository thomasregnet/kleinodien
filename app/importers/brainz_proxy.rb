# frozen_string_literal: true

# Get data from MusicBrainz
class BrainzProxy
  class << self; attr_reader :last_request end
  @last_request = 0

  def initialize(import_order:)
    @import_order = import_order
    @cache        = {}
  end

  attr_reader :import_order, :cache

  def cache_store(import_request, blueprint)
    cache[import_request.to_uri] = blueprint
  end

  def cached?(what, code)
    cache.key?(uri_for(what, code))
  end

  def get(what, code)
    uri = uri_for(what, code)

    blueprint = cache[uri]
    return blueprint if blueprint

    import_request = import_request_for(what, code)

    fetch(import_request)
  end

  def fetch(import_request)
    if locked?
      raise(
        ImportError::ProxyLocked,
        "Proxy is locked but #{import_request.to_uri} is  not cached"
      )
    end

    blueprint = BrainzFetcher.call(import_request: import_request)
    cache_store(import_request, blueprint)
  end

  def last_request
    self.class.last_request
  end

  def lock
    cache.freeze
  end

  def locked?
    cache.frozen?
  end

  def validate_import_request(import_request)
    pre_existing_import_order = import_request.import_order ||= import_order
    return if pre_existing_import_order == import_order

    raise ArgumentError, 'ImportOrder missmatch'
  end

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
