# Base class for MusicBrainz references
class NewBrainzReference < NewReference
  URI_HOST        = 'musicbrainz.org'.freeze
  URI_PATH_PREFIX = 'ws/2'.freeze

  def host
    URI_HOST
  end

  def path_prefix
    URI_PATH_PREFIX
  end
end
