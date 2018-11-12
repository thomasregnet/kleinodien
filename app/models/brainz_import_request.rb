# frozen_string_literal: true

# Base class for MusicBrainz import requests
class BrainzImportRequest < ImportRequest
  BRAINZ_URI_PREFIX = 'https://musicbrainz.org/ws/2'
  BRAINZ_DEFAULT_QUERY_STRING = ''

  def prefix
    BRAINZ_URI_PREFIX
  end

  def to_uri
    "#{prefix}/#{kind}/#{code}#{query_string}"
  end

  def kind
    raise NotImplementedError, "#{self.class} does not implement \#kind"
  end

  def query_string
    BRAINZ_DEFAULT_QUERY_STRING
  end
end
