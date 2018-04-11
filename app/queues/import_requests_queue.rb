class ImportRequestsQueue
  include RedisQueue
  include ImportStore

  queue_name :requests
  redis import_store

  def initialize(args)
    @importer_name = args[:importer_name]
  end
end
