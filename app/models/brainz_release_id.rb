# Source id for a MusicBrainz Release
class BrainzReleaseId < BrainzId
  include BrainzCacheKey
  URL_PREFIX   = 'https://musicbrainz.org/ws/2/release/'.freeze
  QUERY_STRING = '?inc=artists+labels+recordings+release-groups'.freeze

  attr_reader :kind, :query_string, :url_prefix

  def self.source_id(uuid)
    new(value: uuid).source_id
  end

  def initialize(args)
    super(args)
    @kind         = args[:kind]         || 'release'
    @url_prefix   = args[:url_prefix]   || URL_PREFIX
    @query_string = args[:query_string] || QUERY_STRING
  end

  # TODO: source_id must return string without https://musicbrainz.org...
  def source_id
    "#{schema}://#{host}/#{path_prefix}/#{kind}/#{value}#{query_string}"
  end
end
