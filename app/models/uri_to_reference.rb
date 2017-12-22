require 'uri'

# Returns a reference instance for the uri
class UriToReference
  attr_reader :uri

  def self.perform(uri)
    new(uri).perform
  end

  def initialize(uri)
    @uri = URI(uri)
  end

  def perform
    case uri.host
    when 'musicbrainz.org'
      perform_brainz
    end
  end

  def perform_brainz
    case path_to_array[-2]
    when 'artist'
      BrainzArtistReference.from_uri(uri.to_s)
    end
  end

  def path_to_array
    uri.path.split('/').reject { |element| element == '' }
  end
end
