# frozen_string_literal: true

# Append an Import request to an importer queue
class QueueImportService
  include CallWithArgs
  include ImportStoreRequestsAndUrisKey
  include ImportStoreCommons

  private

  attr_reader :importer_name, :request

  def initialize(args)
    @importer_name = args[:importer_name]
    @request       = args[:request]
  end

  def private_call
    import_store.rpush(requests_key, request)
  end
end
