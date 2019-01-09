# frozen_string_literal: true

# Convert a mm:ss String to milliseconds
class Mmss
  def self.milliseconds(duration_string)
    new(duration_string).milliseconds
  end

  def initialize(duration_string)
    return unless /^\d+:\d\d$/ =~ duration_string

    @pieces = duration_string.split(':').map(&:to_i)
    @pieces = nil if @pieces[1] >= 60
  end

  attr_reader :pieces

  def milliseconds
    return unless pieces

    (pieces[0] * MINUTE_MS) + (pieces[1] * SECOND_MS)
  end
end
