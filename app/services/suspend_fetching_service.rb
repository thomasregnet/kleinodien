class SuspendFetchingService
  include CallWithArgs

  private

  attr_reader :response

  def initialize(args)
    @response = args[:response]
  end

  def private_call
    # the code for the service belongs here
  end
end
