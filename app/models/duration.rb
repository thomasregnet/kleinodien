class Duration
  SECOND_MS = 1000
  MINUTE_MS = 60_000
  HOUR_MS   = 3_600_000

  attr_reader :milliseconds, :accuracy

  def self.milliseconds(milliseconds)
    new(milliseconds, 'millisecond')
  end

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

  def hours
    @milliseconds / HOUR_MS
  end

  def minutes
    @milliseconds / MINUTE_MS
  end

  def seconds
    @milliseconds / SECOND_MS
  end

  def minutes_left
    @milliseconds % HOUR_MS / MINUTE_MS
  end

  def minutes_left_rounded
    minutes = minutes_left
    ms_left = @milliseconds - (minutes * MINUTE_MS) - (hours * HOUR_MS)
    minutes += 1 if ms_left >= 30_000
    minutes
  end

  def seconds_left_rounded
    (@milliseconds % MINUTE_MS / SECOND_MS.to_f).round
  end

  def mmss
    [minutes.to_s, seconds_left_rounded.to_s].join(':')
  end

  def hhmm
    [hours.to_s, minutes_left_rounded.to_s].join(':')
  end
  
  def hhmmss
    [hours.to_s, minutes_left.to_s, seconds_left_rounded.to_s].join(':')
  end
end
