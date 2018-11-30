# frozen_string_literal: true

# Calculate interruptions for MusicBrainz import requests
class CalculateBrainzNap
  include Singleton

  def self.call(args)
    instance.call(args)
  end

  def initialize
    @last            = Time.new(1970)
    @last_multiplier = 1
    @now             = Time.now
  end

  attr_reader :error, :last, :last_multiplier, :now

  def call(error)
    return 0 if min_nap_time <= delta

    @error = error
    nap_time = delta - required_nap_time
    @last = now
    nap_time
  end

  def default_nap_time
    1
  end

  def delta
    now - last
  end

  def multiplier
    @last_multiplier = CalculateBrainzNapMultiplier.call(
      error:           error,
      last_multiplier: last_multiplier
    )
  end

  def min_nap_time
    default_nap_time * multiplier
  end
end
