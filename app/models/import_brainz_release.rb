class ImportBrainzRelease
  def self.perform(data, response)
    response.body = 'foobar'
    response
  end
end
