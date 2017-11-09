# References a MusicBrainz Artist
class BrainzArtistRef < BrainzRef
  BRAINZ_KIND  = 'artist'.freeze
  QUERY_STRING = '?inc=url-rels'.freeze

  def initialize(args)
    args[:kind]         ||= BRAINZ_KIND
    args[:query_string] ||= QUERY_STRING
    super(args)
  end
end
