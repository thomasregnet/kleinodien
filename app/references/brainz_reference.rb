# frozen_string_literal: true

# Base class for MusicBrainz references
class BrainzReference < ReferenceBase
  scheme          :https
  category        :brainz
  host            'musicbrainz.org'
  path_prefix     'ws/2'

  def to_key
    return key if key
    "#{host}/#{kind}/#{to_code}?#{query_string}"
  end

  def to_uri
    return uri if uri
    "#{scheme}://#{host}/#{path_prefix}/#{kind}/#{to_code}?#{query_string}"
  end
end
