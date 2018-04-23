# frozen_string_literal: true

# A reference to a MusicBrainz Artist
class BrainzArtistReference < BrainzReferenceBase
  kind         :artist
  query_string 'inc=url-rels'
end
