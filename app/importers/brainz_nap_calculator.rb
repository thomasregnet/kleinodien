# frozen_string_literal: true

# Calculate interruptions for MusicBrainz import requests
class BrainzNapCalculator
  class << self; attr_reader :last end
  @last = 0

  def self.call(args)
    new(args).call
  end

  def intialize(args)
    @error = args[:error]
    @now   = Time.now
  end

  attr_reader :error, :now

  def call
    return 0 if min_nap_time <= delta

    nap_time = delta - required_nap_time
    @last = now
    nap_time
  end

  def delta
    now - last
  end

  def multiplier
    return reset_multiplier unless error
    return @multiplier if @multiplier >= max_multiplier

    @multiplier += 1
  end

  def reset_multiplier
    @multiplier = 1
  end

  def max_multiplier
    5
  end

  def min_nap_time
    default_nap_time * multiplier
  end
end
