class RequestBrainzReleaseImportService
  include CallWithArgs
  include ImportStore
  include QueueRequest

  # private

  attr_reader :import_request

  def initialize(import_request)
    @import_request = import_request
  end

  def private_call
    queue_name = queue_name_for(:brainz)
    import_store.rpush('brainz:queue', import_request.to_json)
  end
end
