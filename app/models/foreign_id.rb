class ForeignId
  attr_reader :value

  def initialize(args)
    @value = args[:value]
  end
end
