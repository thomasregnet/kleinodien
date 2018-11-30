# frozen_string_literal: true

# Calculate interruptions for MusicBrainz import requests
class CalculateBrainzNap
  class << self
    attr_reader :last, :last_multiplier
  end

  @last            = 0
  @last_multiplier = 1

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
    CalculateBrainzNapMultiplier.call(
      error:           error,
      last_multiplier: last_multiplier
    )
  end

  def min_nap_time
    default_nap_time * multiplier
  end
end
