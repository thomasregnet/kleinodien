# frozen_string_literal: true

# Import-request for MusicBrainz artists
class BrainzArtistImportRequest < BrainzImportRequest
  QUERY_KIND = 'artist'

  def kind
    QUERY_KIND
  end

  def query_string
    BRAINZ_ARTIST_QUERY_STRING
  end
end
