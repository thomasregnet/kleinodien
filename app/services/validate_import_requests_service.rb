class ValidateImportRequestsService
  include CallWithArgs
  include ImportStoreCommons

  private

  attr_reader :importer_name

  def initialize(args)
    @importer_name = args[:importer_name]
  end

  def private_call
    return true unless uris_length.positive?
    return true if requests_lenght.positive?
    false
  end

  def requests_lenght
    import_store.llen requests_key
  end

  def uris_length
    import_store.llen uris_key
  end

  def requests_key
    "#{importer_name}:requests"
  end

  def uris_key
    "#{importer_name}:uris"
  end
end
