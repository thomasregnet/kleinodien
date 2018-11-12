# frozen_string_literal: true

# Get data from MusicBrainz
class BrainzDataFetcher
  class << self; attr_reader :last_request end
  @last_request = 0

  def initialize
    @store = {}
  end

  attr_reader :store

  # TODO: Remove the hard-coded uri
  # TODO: Take an ImportRequest object as parameter
  def get(uri)
    result = Faraday.get(uri)
    BrainzBaseBlueprint.from_xml(result.body)
  end

  def last_request
    self.class.last_request
  end
end
