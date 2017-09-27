class ImportBrainzRelease

  attr_reader :data, :response

  def self.perform(data, response)
    new(data,response).perform
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
    'foobar'
  end
end
