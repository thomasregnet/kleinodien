# Extract import parameters from an uri-string
class ExtractImportOrderParamsService
  def self.call(uri_string)
    new(uri_string).call
  end

  attr_reader :uri

  def initialize(uri_string)
    @uri = URI(uri_string)
  end

  def call
    # TODO: add and choose other specific parameter extractors
    result = ExtractBrainzImportParamsService.call(uri)
    # TODO: replace hard coded type
    result[:type] = 'MusicBrainzImportOrder'
    result
  end
end
