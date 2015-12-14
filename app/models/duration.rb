class Duration
  SECOND_MS = 1000
  MINUTE_MS = 60_000
  HOUR_MS   = 3_600_000

  attr_reader :milliseconds, :accuracy

  def self.seconds(seconds)
    new(seconds * SECOND_MS, 'second')
  end

  def self.minutes(minutes)
    new(minutes * MINUTE_MS, 'minute')
  end

  def self.hours(hours)
    new(hours * HOUR_MS, 'hour')
  end

  def self.mmss(mmss)
    mm, ss = mmss.split(':')
    milliseconds = (mm.to_i * MINUTE_MS) + (ss.to_i * SECOND_MS)
    new(milliseconds, 'second')
  end

  def self.hhmm(hhmm)
    hh, mm = hhmm.split(':')
    milliseconds = (hh.to_i * HOUR_MS) + (mm.to_i * MINUTE_MS)
    new(milliseconds, 'minute')
  end

  def self.hhmmss(hhmmss)
    hh, mm, ss = hhmmss.split(':')
    milliseconds = (hh.to_i * HOUR_MS) +
                   (mm.to_i * MINUTE_MS) +
                   (ss.to_i * SECOND_MS)
    new(milliseconds, 'second')
  end
  
  def initialize(milliseconds, accuracy = 'millisecond')
    @milliseconds = milliseconds
    @accuracy     = accuracy
  end
end
