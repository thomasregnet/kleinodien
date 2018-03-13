# For service classes called with an arguments hash
module CallWithArgs
  extend ActiveSupport::Concern

  # extend the including class with .call
  module ClassMethods
    def call(args)
      new(args).call
    end
  end

  def call
    private_call
  end
end
