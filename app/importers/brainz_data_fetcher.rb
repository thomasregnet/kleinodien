# frozen_string_literal: true

# Get data from MusicBrainz
class BrainzDataFetcher
  class << self; attr_reader :last_request end
  @last_request = 0

  def initialize
    @store = {}
  end

  attr_reader :store

  def get(uri)
    uri = 'https://musicbrainz.org/ws/2/release/7452f8c9-f9bc-3ca7-859e-3220e57e4e4a?inc=artists+labels+recordings+release-groups'

    result = Faraday.get(uri)
    BrainzBaseBlueprint.from_xml(result.body)
  end

  def last_request
    self.class.last_request
  end
end
