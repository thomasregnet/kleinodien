# frozen_string_literal: true

# ImportRequest for release cover art
class CoverArtReleaseManifestImportRequest < CoverArtImportRequest
  QUERY_KIND = 'release'

  def kind
    QUERY_KIND
  end

  def query_string
    CoverArt_RELEASE_QUERY_STRING
  end
end
