class ImportUrisQueue
  include RedisQueue

  name :uris

  def initialize(args)
    @importer_name = args[:importer_name]
  end
end
