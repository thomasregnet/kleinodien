# Source id for a MusicBrainz Artist
class BrainzArtistId < BrainzId
  attr_reader :query_string

  def initialize(args)
    super(args)
    @query_string = args[:query_string] || '?inc=url-rels'
  end

  def self.source_id(uuid)
    new(value: uuid).source_id
  end

  def source_id
    path_prefix + value + query_string
  end
end
