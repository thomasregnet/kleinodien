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
    result = Faraday.get(import_request.to_uri)
    BrainzBlueprint.from_xml(result.body)
  end

  def last_request
    self.class.last_request
  end
end
