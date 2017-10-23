# Base class for MusicBrainzIds
class BrainzId < ForeignId
  @host        = 'musicbrainz.org'
  @path_prefix = 'ws/2'
  @schema      = 'https'

  class << self
    attr_reader :host, :path_prefix, :schema
  end

  # The following methods must call BrainzID.class_method
  # otherwise, when calling self.class.class_method
  # they return nil when inherited
  # This method smells of :reek:UtilityFunction
  def host
    BrainzId.host
  end

  # This method smells of :reek:UtilityFunction
  def path_prefix
    BrainzId.path_prefix
  end

  # This method smells of :reek:UtilityFunction
  def schema
    BrainzId.schema
  end
end
