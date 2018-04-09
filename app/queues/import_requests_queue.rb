class ImportRequestsQueue
  include RedisQueue

  name :requests

  def initialize(args)
    @importer_name = args[:importer_name]
  end
end
