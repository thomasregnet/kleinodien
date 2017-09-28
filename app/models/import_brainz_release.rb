# Post MusicBrainz data to kleinodien
class ImportBrainzRelease
  attr_reader :data, :response

  def self.perform(data, response)
    new(data, response).perform
  end

  def initialize(data, response)
    @data     = data[:data]
    @response = response
  end

  def perform
    response.body = body
    response.status = 202
    response
  end

  def body
    {
      data:
        {
          attributes:
            {
              required: {
                musicbrainz: [
                  required('release', data[:attributes][:wanted])
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
