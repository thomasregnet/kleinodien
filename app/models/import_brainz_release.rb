# Post MusicBrainz params to kleinodien
class ImportBrainzRelease
  URL_PREFIX = 'http://musicbrainz.org/ws/2/release/'.freeze
  QUERY_STRING = '?inc=artists+labels+recordings+release-groups'.freeze

  attr_reader :params, :cache

  def self.perform(params)
    new(params).perform
  end

  def initialize(params)
    @params = params
    @cache  = ImportCache.new
  end

  def perform
    prepare
    body
  end

  def body
    brainz_id = params[:data][:attributes][:wanted]
    cache.require_brainz(brainz_release_url_for(brainz_id))
    {
      data:
        {
          attributes: body_attributes
        }
    }
  end

  def body_attributes
    attributes = {}
    attributes[:http_status_code] = 202
    attributes[:required] = cache.required if cache.any_required?
    attributes
  end

  def prepare
    # TODO: check if the brainz release already exists in the database
    release_url = brainz_release_url
    return if cache.known['brainz'][brainz_release_url]
    cache.require_brainz(release_url) unless cache.fetch_brainz(release_url)
  end

  def brainz_release_url
    brainz_release_url_for(params[:data][:attributes][:wanted])
  end

  def brainz_release_url_for(brainz_id)
    URL_PREFIX + brainz_id + QUERY_STRING
  end
end
