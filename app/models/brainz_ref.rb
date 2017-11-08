# Base class for MusicBrainz references
class BrainzRef < Reference
  attr_reader :host, :path_prefix, :schema

  def initialize(args)
    super(args)
    @host        = args[:host]        || 'musicbrainz.org'
    @path_prefix = args[:path_prefix] || 'ws/2'
    @schema      = args[:schema]      || 'https'
  end
end
