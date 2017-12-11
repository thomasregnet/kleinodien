# Base class for MusicBrainz references
class BrainzReference < Reference
  URI_HOST        = 'musicbrainz.org'.freeze
  URI_PATH_PREFIX = 'ws/2'.freeze

  def host
    URI_HOST
  end

  def path_prefix
    URI_PATH_PREFIX
  end

  def to_key
    return key if key
    "#{host}/#{kind}/#{to_code}?#{query_string}"
  end

  def to_uri
    return uri if uri
    "#{scheme}://#{host}/#{path_prefix}/#{kind}/#{to_code}?#{query_string}"
  end
end
