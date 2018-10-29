class GetImportStoreService
  def self.call(uri_string)
    new(uri_string).call
    'MusicBrainzImportOrder'
  end

  def new(uri_string)
    @uri_string = uri_string
  end

  def call
    'MusicBrainzImportOrder'
  end
end
