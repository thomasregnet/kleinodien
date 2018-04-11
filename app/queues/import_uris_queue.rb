class ImportUrisQueue
  include ImportStore
  include RedisQueue

  queue_name :uris
  redis import_store

  def initialize(args)
    @importer_name = args[:importer_name]
  end
end
