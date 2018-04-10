class ValidateImportRequestsService
  include CallWithArgs
  include ImportQueuesConsumption

  private

  attr_reader :importer_name

  def initialize(args)
    @importer_name = args[:importer_name]
  end

  def private_call
    return true unless import_uris.length.positive?
    return true if import_requests.length.positive?
    false
  end
end
