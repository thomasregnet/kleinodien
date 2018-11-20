class BrainzArtistImportRequest < BrainzImportRequest
  QUERY_KIND = 'artist'
  QUERY_STRING = 'inc=url-rels'

  def kind
    QUERY_KIND
  end

  def query_string
    QUERY_STRING
  end
end
