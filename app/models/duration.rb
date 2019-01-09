# frozen_string_literal: true

class Duration
  # 2019-01-08: Moved constants to config/initializers/constants.rb
  # ACCURACY_MILLISECOND = 'millisecond'
  # ACCURACY_SECOND      = 'second'
  # ACCURACY_MINUTE      = 'minute'
  # ACCURACY_HOUR        = 'hour'

  # SECOND_MS = 1_000
  # MINUTE_MS = 60_000
  # HOUR_MS   = 3_600_000

  attr_reader :milliseconds, :accuracy

  def self.milliseconds(milliseconds)
    new(milliseconds, ACCURACY_MILLISECOND)
  end

  def self.seconds(seconds)
    new(seconds * SECOND_MS, ACCURACY_SECOND)
  end

  def self.minutes(minutes)
    new(minutes * MINUTE_MS, ACCURACY_MINUTE)
  end

  def self.hours(hours)
    new(hours * HOUR_MS, ACCURACY_HOUR)
  end

  def self.mmss(mmss)
    milliseconds = Mmss.milliseconds(mmss)
    new(milliseconds, ACCURACY_SECOND)
  end

  def self.hhmm(hhmm)
    milliseconds = Hhmm.milliseconds(hhmm)
    new(milliseconds, ACCURACY_MINUTE)
  end

  def self.hhmmss(hhmmss)
    milliseconds = Hhmmss.milliseconds(hhmmss)
    new(milliseconds, ACCURACY_SECOND)
  end

  def initialize(milliseconds, accuracy = ACCURACY_MILLISECOND)
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
    [minutes.to_s, padding(seconds_left_rounded)].join(':')
  end

  def hhmm
    [hours.to_s, padding(minutes_left_rounded)].join(':')
  end

  def hhmmss
    [
      hours.to_s,
      padding(minutes_left),
      padding(seconds_left_rounded)
    ]
      .join(':')
  end

  def padding(number)
    format('%02d', number)
  end
end
