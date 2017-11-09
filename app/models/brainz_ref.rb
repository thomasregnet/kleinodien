# Base class for MusicBrainz references
class BrainzRef < Reference
  BRAINZ_HOST = 'musicbrainz.org'.freeze
  PATH_PREFIX = 'ws/2'.freeze
  URI_SCHEMA  = 'https'.freeze

  attr_reader :host, :path_prefix, :schema

  def initialize(args)
    super(args)
    @host        = args[:host]        || BRAINZ_HOST
    @path_prefix = args[:path_prefix] || PATH_PREFIX
    @schema      = args[:schema]      || URI_SCHEMA
  end
end
