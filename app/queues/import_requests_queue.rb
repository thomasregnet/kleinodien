class ImportRequestsQueue
  include RedisQueue

  attr_reader :importer_name

  def initialize(args)
    @importer_name = args[:importer_name]
  end

  def queue_name
    "#{importer_name}:requests:queue"
  end
end
