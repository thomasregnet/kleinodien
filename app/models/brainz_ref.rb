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

  def ==(other)
    return false unless self.class == other.class
    return false unless other.code == code
    return false unless other.host == host
    return false unless other.kind == kind
    return false unless other.path_prefix == path_prefix
    return false unless other.schema == schema
    return false unless other.query_string == query_string
    true
  end

  alias_method 'eql?', '=='

  # TODO: def hash
  # see https://ruby-doc.org/core-2.4.2/Hash.html#class-Hash-label-Hash+Keys
end
