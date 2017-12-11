# Reference to a MusicBrainz release
class NewBrainzReleaseReference < NewBrainzReference
  URI_KIND         = 'release'.freeze
  URI_QUERY_STRING = 'inc=artists+labels+recordings+release-groups'.freeze

  def kind
    URI_KIND
  end

  def query_string
    URI_QUERY_STRING
  end
end
