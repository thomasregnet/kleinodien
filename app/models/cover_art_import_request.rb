# frozen_string_literal: true

# Base class for MusicBrainz import requests
class CoverArtImportRequest < ImportRequest
  include CodeUuidValidation

  COVER_ART_URI_PREFIX = 'https://coverartarchive.org'
  COVER_ART_DEFAULT_QUERY_STRING = ''

  def prefix
    COVER_ART_URI_PREFIX
  end

  def to_uri
    "#{prefix}/#{kind}/#{code}"
  end

  def kind
    raise NoMethodError
  end
end
