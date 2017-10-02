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
    {
      data:
        {
          attributes:
            {
              required: {
                musicbrainz: [
                  required('release', params[:data][:attributes][:wanted])
                ]
              }
            }
        }
    }.to_json
  end

  def required(type, id)
    path = "#{type}/#{id}"
    {
      type: type,
      id:   id,
      attributes: {
        url: "http://musicbrainz.org/ws/2/#{path}",
        query_string: 'inc=artists+labels+recordings+release-groups',
        path: path
      }
    }
  end
end
