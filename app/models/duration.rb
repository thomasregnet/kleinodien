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

  def self.mmss(mmss)
    mm, ss = mmss.split(':')
    milliseconds = (mm.to_i * 60_000) + (ss.to_i * 1000)
    new(milliseconds, 'second')
  end

  def self.hhmm(hhmm)
    hh, mm = hhmm.split(':')
    milliseconds = (hh.to_i * 3_600_000) + (mm.to_i * 60_000)
    new(milliseconds, 'minute')
  end

  def self.hhmmss(hhmmss)
    hh, mm, ss = hhmmss.split(':')
    milliseconds = (hh.to_i * 3_600_000) + (mm.to_i * 60_000) + (ss.to_i * 1000)
    new(milliseconds, 'second')
  end
  
  def initialize(milliseconds, accuracy = 'millisecond')
    @milliseconds = milliseconds
    @accuracy     = accuracy
  end
end
