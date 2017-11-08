# Base class for external references
class Reference
  attr_reader :code 
  def initialize(args)
    @code = args[:code]
  end
end
