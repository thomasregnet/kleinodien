class ExtractImportOrderParamsService
  # include CallWithArgs

  def self.call(uri_string)
    new(uri_string).call
  end


  attr_reader :uri

  def initialize(uri_string)
    @uri = URI(uri_string)
  end

  def call
    { code: 123.to_s, kind: 'artist' }
    # the code for the service belongs here
  end
end
