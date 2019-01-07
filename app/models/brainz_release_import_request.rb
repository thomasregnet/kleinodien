# frozen_string_literal: true

# ImportRequest for MusicBrainz Releases
class BrainzReleaseImportRequest < BrainzImportRequest
  QUERY_KIND = 'release'

  def kind
    QUERY_KIND
  end

  def query_string
    BRAINZ_RELEASE_QUERY_STRING
  end
end
