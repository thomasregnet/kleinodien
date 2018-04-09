class ImportUrisQueue
  include RedisQueue

  attr_reader :importer_name

  def initialize(args)
    @importer_name = args[:importer_name]
  end

  def queue_name
    "#{importer_name}:queue:uris"
  end
end
