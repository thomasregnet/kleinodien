module ImportQueuesConsumption
  extend ActiveSupport::Concern

  def import_uris
    @import_uris ||= ImportUrisQueue.new(importer_name: importer_name)
  end

  def import_requests
    @import_requests ||= ImportRequestsQueue.new(importer_name: importer_name)
  end
end
