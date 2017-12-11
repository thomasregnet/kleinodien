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

  def to_uri
    return uri if uri
    "#{scheme}://#{host}/#{path_prefix}/#{kind}/#{to_code}?#{query_string}"
  end
end
