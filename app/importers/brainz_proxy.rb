# frozen_string_literal: true

# Get data from MusicBrainz
class BrainzProxy
  class << self; attr_reader :last_request end
  @last_request = 0

  def initialize(args)
    @import_order = args[:import_order]
    @locked       = false
    @cache        = {}
  end

  attr_reader :import_order, :cache

  def cache_store(import_request, blueprint)
    cache[import_request.to_uri] = blueprint
  end

  def get(import_request)
    validate_import_request(import_request)

    uri = import_request.to_uri

    blueprint = cache[uri]
    return blueprint if blueprint

    fetch(import_request)
  end

  def fetch(import_request)
    if locked?
      raise(
        ImportError::ProxyLocked,
        "Proxy is locked but #{uri} is  not cached"
      )
    end

    blueprint = BrainzFetcher.call(import_request: import_request)
    cache_store(import_request, blueprint)
  end

  def last_request
    self.class.last_request
  end

  def lock
    @locked = true
  end

  def locked?
    @locked
  end

  def validate_import_request(import_request)
    pre_existing_import_order = import_request.import_order ||= import_order
    return if pre_existing_import_order == import_order

    raise ArgumentError, 'ImportOrder missmatch'
  end
end
