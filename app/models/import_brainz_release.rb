# Post MusicBrainz params to kleinodien
class ImportBrainzRelease
  attr_reader :params, :cache

  def self.perform(params, cache)
    new(params, cache).perform
  end

  def initialize(params, cache)
    @params  = params
    @cache = cache
  end

  def perform
    #cache.body = body
    #cache.status = 202
    body
  end

  def body
    brainz_id = params[:data][:attributes][:wanted]
    cache.require_brainz_compilation_release(brainz_id, required(brainz_id))
    {
      data:
        {
          attributes:
            {
              required: {
                brainz: {
                  brainz_id => required(brainz_id)
                }
              }
            }
        }
    }.to_json
  end

  def required(brainz_id)
    "http://musicbrainz.org/ws/2/release/#{brainz_id}?inc=artists+labels+recordings+release-groups"
  end
end
