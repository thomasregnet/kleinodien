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
    body
  end

  def body
    brainz_id = params[:data][:attributes][:wanted]
    cache.require_brainz(brainz_release_url_for(brainz_id))
    {
      data:
        {
          attributes:
            {
              required: {
                brainz: [
                  brainz_release_url_for(brainz_id)
                ]
              }
            }
        }
    }.to_json
  end

  def brainz_release_url_for(brainz_id)
    URL_PREFIX + brainz_id + QUERY_STRING
  end
end
