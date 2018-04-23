# frozen_string_literal: true

# Reference to a MusicBrainz release
class BrainzReleaseReference < BrainzReferenceBase
  kind :release
  query_string 'inc=artists+labels+recordings+release-groups'
end
