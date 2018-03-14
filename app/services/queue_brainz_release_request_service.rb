class QueueBrainzReleaseRequestService
  include CallWithArgs
  include ImportStore

  # private

  attr_reader :import_request

  def initialize(import_request)
    @import_request = import_request
  end

  def private_call
    import_store.rpush('brainz:queue', import_request.to_json)
  end
end
