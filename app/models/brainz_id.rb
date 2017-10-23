# Base class for MusicBrainzIds
class BrainzId < ForeignId
  @host        = 'musicbrainz.org'
  @path_prefix = 'ws/2'
  @schema      = 'https'

  class << self
    attr_reader :host, :path_prefix, :schema
  end

  def host
    self.class.host
  end

  def path_prefix
    self.class.path_prefix
  end

  def schema
    self.class.schema
  end
end
