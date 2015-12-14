class Duration
  attr_reader :milliseconds, :accuracy

  def self.seconds(seconds)
    new(seconds * 1000, 'second')
  end

  def self.minutes(minutes)
    new(minutes * 60_000, 'minute')
  end

  def self.hours(hours)
    new(hours * 3_600_000, 'hour')
  end
  
  def initialize(milliseconds, accuracy = 'millisecond')
    @milliseconds = milliseconds
    @accuracy     = accuracy
  end
end
