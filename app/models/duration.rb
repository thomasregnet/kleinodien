class Duration
  attr_reader :milliseconds, :accuracy

  def initialize(milliseconds, accuracy = 'millisecond')
    @milliseconds = milliseconds
    @accuracy     = accuracy
  end
end
