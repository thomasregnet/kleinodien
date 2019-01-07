class BrainzReleaseGroupImportRequest < BrainzImportRequest
  QUERY_KIND = 'release-group'

  def kind
    QUERY_KIND
  end

  def query_string
    BRAINZ_RELEASE_GROUP_QUERY_STRING
  end
end
