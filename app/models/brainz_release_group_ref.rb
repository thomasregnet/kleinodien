# References a MusicBrainz release-group
class BrainzReleaseGroupRef < BrainzRef
  BRAINZ_KIND  = 'release-group'.freeze
  QUERY_STRING = '?inc=artists+url-rels'.freeze

  def initialize(args)
    args[:kind]         ||= BRAINZ_KIND
    args[:query_string] ||= QUERY_STRING
    super(args)
  end
end
