# A reference to a MusicBrainz Artist
class NewBrainzArtistReference < NewBrainzReference
  URI_KIND         = 'artist'.freeze
  URI_QUERY_STRING = 'inc=url-rels'.freeze

  def kind
    URI_KIND
  end

  def query_string
    URI_QUERY_STRING
  end
end
