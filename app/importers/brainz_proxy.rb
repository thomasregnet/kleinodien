# frozen_string_literal: true

# Get data from MusicBrainz
class BrainzProxy
  class << self; attr_reader :last_request end
  @last_request = 0

  def initialize(args)
    @import_order = args[:import_order]
    @store = {}
  end

  attr_reader :import_order, :store

  def get(import_request)
    import_request_import_order(import_request)
    result = Faraday.get(import_request.to_uri)
    BrainzBlueprint.from_xml(result.body)
  end

  def import_request_import_order(import_request)
    pre_existing_import_order = import_request.import_order ||= import_order
    return if pre_existing_import_order == import_order

    raise ArgumentError, 'ImportOrder missmatch'
  end

  def last_request
    self.class.last_request
  end
end
