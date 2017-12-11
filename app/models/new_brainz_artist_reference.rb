class NewBrainzArtistReference < NewReference
  def to_uri
    return uri if uri
    "https://musicbrainz.org/ws/2/artist/#{to_code}?inc=url-rels"
  end

end
