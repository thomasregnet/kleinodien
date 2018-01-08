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
    host = uri.host
    case host
    when 'musicbrainz.org'
      perform_brainz
    else
      raise "can't create reference for #{host} of #{self}"
    end
  end

  def perform_brainz
    type = path_to_array[-2]
    case type
    when 'artist'
      BrainzArtistReference.from_uri(to_s)
    when 'release-group'
      BrainzReleaseGroupReference.from_uri(to_s)
    when 'release'
      BrainzReleaseReference.from_uri(to_s)
    else
      raise "can't create reference for #{type} of #{self}"
    end
  end

  def path_to_array
    uri.path.split('/').reject { |element| element == '' }
  end

  def to_s
    uri.to_s
  end
end
