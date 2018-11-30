# frozen_string_literal: true

# Calculate multiplier of nap-time
class CalculateNapMultiplier
  DEFAULT_MAX_MULTIPLIER = 5

  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @error           = args[:error]
    @last_multiplier = args[:last_multiplier]
  end

  attr_reader :error, :last_multiplier

  def call
    raise ArgumentError, 'missing last_multiplier' unless last_multiplier
    return 1 unless error

    return max_multiplier if last_multiplier >= max_multiplier

    last_multiplier + 1
  end

  def max_multiplier
    DEFAULT_MAX_MULTIPLIER
  end
end
