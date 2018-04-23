# frozen_string_literal: true

# A reference to a MusicBrainz Artist
class BrainzArtistReference < BrainzReference
  kind         :artist
  query_string 'inc=url-rels'
end
