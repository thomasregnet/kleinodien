# frozen_string_literal: true

# References a MusicBrainz release-group
class BrainzReleaseGroupReference < BrainzReferenceBase
  kind 'release-group'
  query_string 'inc=artists+url-rels'
end
