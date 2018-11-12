# frozen_string_literal: true

# ImportRequest for MusicBrainz Releases
class BrainzReleaseImportRequest < BrainzImportRequest
  QUERY_KIND   = 'release'
  QUERY_STRING = 'inc=artists+labels+recordings+release-groups'

  def kind
    QUERY_KIND
  end

  def query_string
    QUERY_STRING
  end
end
