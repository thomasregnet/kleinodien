# References a MusicBrainz Artist
class BrainzArtistRef < BrainzRef
  attr_reader :query_string

  def initialize(args)
    super(args)
    @kind         = args[:kind]         || 'artist'
    @query_string = args[:query_string] || '?inc=url-rels'
  end

  # TODO: remove source_id
  def self.source_id(uuid)
    new(code: uuid).source_id
  end

  def source_id
    path_prefix + code + query_string
  end
end
