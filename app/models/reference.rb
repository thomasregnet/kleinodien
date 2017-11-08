# Base class for external references
class Reference
  attr_reader :value 
  def initialize(args)
    @value = args[:value]
  end
end
