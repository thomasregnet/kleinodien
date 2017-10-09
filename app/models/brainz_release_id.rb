class BrainzReleaseId
  URL_PREFIX = 'https://musicbrainz.org/ws/2/release/'.freeze
  QUERY_STRING = '?inc=artists+labels+recordings+release-groups'.freeze

  attr_reader :id

  def self.source_id(uuid)
    new(uuid).source_id
  end

  def initialize(uuid)
    @id = uuid
  end

  # TODO: source_id must return string without https://musicbrainz.org...
  def source_id
    URL_PREFIX + id + QUERY_STRING
  end
end
