# frozen_string_literal: true

# Append an Import request to an importer queue
class QueueImportService < ServiceBase
  include ImportQueuesConsumption

  def initialize(args)
    @importer_name = args[:importer_name]
    @request       = args[:request]
  end

  attr_reader :importer_name, :request

  def call
    import_requests.enq(request.as_json)
  end
end
