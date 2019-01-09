# forzen_string_literal: true

# validates a time in hh:mm:ss format and returns milliseconds
class Hhmmss < Mmss
  def self.milliseconds(hhmmss)
    new(hhmmss).milliseconds
  end

  def initialize(hhmmss)
    return unless /^\d+:\d\d:\d\d$/ =~ hhmmss

    @pieces = hhmmss.split(':').map(&:to_i)
    @pieces = nil unless pieces_valid?
  end

  def milliseconds
    return unless pieces

    (pieces[0] * HOUR_MS) +
      (pieces[1] * MINUTE_MS) +
      (pieces[2] * SECOND_MS)
  end

  def pieces_valid?
    return false if pieces[1] >= 60 # minutes
    return false if pieces[2] >= 60 # seconds

    true
  end
end
