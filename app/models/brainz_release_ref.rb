# References a MusicBrainz release
class BrainzReleaseRef < BrainzRef
  BRAINZ_KIND  = 'release'.freeze
  URL_PREFIX   = 'https://musicbrainz.org/ws/2/release/'.freeze
  QUERY_STRING = '?inc=artists+labels+recordings+release-groups'.freeze

  attr_reader :url_prefix

  def initialize(args)
    args[:kind]         ||= BRAINZ_KIND
    args[:url_prefix]   ||= URL_PREFIX
    args[:query_string] ||= QUERY_STRING
    super(args)
  end
end
