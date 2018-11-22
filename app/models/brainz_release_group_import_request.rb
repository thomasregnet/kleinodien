class BrainzReleaseGroupImportRequest < BrainzImportRequest
  QUERY_KIND = 'release-group'
  QUERY_STRING = 'inc=artists+artist-rels+label-rels+url-rels'

  def kind
    QUERY_KIND
  end

  def query_string
    QUERY_STRING
  end
end
