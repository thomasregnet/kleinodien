# frozen_string_literal: true

# Get data from MusicBrainz
class BrainzProxy
  class << self; attr_reader :last_request end
  @last_request = 0

  def initialize
    @store = {}
  end

  attr_reader :store

  def get(import_request)
    result = Faraday.get(import_request.to_uri)
    BrainzBlueprint.from_xml(result.body)
  end

  def last_request
    self.class.last_request
  end
end
