# Source id for a MusicBrainz Artist
class BrainzArtistId
  @query_string = '?inc=url-rels'
  @path_prefix = 'ws/2/artist/'

  class << self
    attr_reader :query_string, :path_prefix
  end

  attr_reader :id

  def query_string
    self.class.query_string
  end

  def path_prefix
    self.class.path_prefix
  end

  def self.source_id(uuid)
    new(uuid).source_id
  end

  def initialize(uuid)
    @id = uuid
  end

  def source_id
    path_prefix + id + query_string
  end
end
