# References a MusicBrainz release-group
class BrainzReleaseGroupReference < BrainzReference
  URI_KIND = 'release-group'.freeze
  URI_QUERY_STRING = 'inc=artists+url-rels'.freeze

  def kind
    URI_KIND
  end

  def query_string
    URI_QUERY_STRING
  end
end
