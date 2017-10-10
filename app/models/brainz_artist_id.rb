class BrainzArtistId
  URL_PREFIX = 'ws/2/artist/'.freeze
  QUERY_STRING = '?inc=currently+unknown'.freeze

  attr_reader :id

  def self.source_id(uuid)
    new(uuid).source_id
  end

  def initialize(uuid)
    @id = uuid
  end

  def source_id
    URL_PREFIX + id + QUERY_STRING
  end
end
