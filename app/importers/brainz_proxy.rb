# frozen_string_literal: true

# Get data from MusicBrainz
class BrainzProxy
  class << self; attr_reader :last_request end
  @last_request = 0

  def initialize(args)
    @import_order  = args[:import_order]
    @locked        = false
    @result_cache  = {}
  end

  attr_reader :import_order, :result_cache

  def get(import_request)
    import_request_import_order(import_request)

    uri = import_request.to_uri

    result = result_cache[uri]
    return result if result

    if locked?
      raise(
        ImportError::ProxyLocked,
        "Proxy is locked but #{uri} is  not cached"
      )
    end

    result = api_connection.get(uri)
    result_cache_store(import_request, result)
  end

  def api_connection
    Faraday.new
  end

  def result_cache_store(import_request, result)
    blueprint = BrainzBlueprint.from_xml(result.body)
    result_cache[import_request.to_uri] = blueprint
  end

  def import_request_import_order(import_request)
    pre_existing_import_order = import_request.import_order ||= import_order
    return if pre_existing_import_order == import_order

    raise ArgumentError, 'ImportOrder missmatch'
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
end
