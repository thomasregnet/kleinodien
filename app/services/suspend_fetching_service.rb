class SuspendFetchingService < ServiceBase
  def initialize(args)
    @response = args[:response]
  end

  attr_reader :response

  def call
    # the code for the service belongs here
  end
end
