# frozen_string_literal: true

# Convert a hh:mm String to milliseconds
class Hhmm < Mmss
  def milliseconds
    return unless pieces

    (pieces[0] * HOUR_MS) + (pieces[1] * MINUTE_MS)
  end
end
