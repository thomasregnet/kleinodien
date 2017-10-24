# Base class for MusicBrainzIds
class BrainzId < ForeignId
  attr_reader :host, :path_prefix, :schema

  def initialize(args)
    super(args)
    @host        = args[:host]        || 'musicbrainz.org'
    @path_prefix = args[:path_prefix] || 'ws/2'
    @schema      = args[:schema]      || 'https'
  end
end
