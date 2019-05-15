# frozen_string_literal: true

# Interrupt imports to comply with MusicBrainz rate limiting
# https://musicbrainz.org/doc/XML_Web_Service/Rate_Limiting
class BrainzImportInterrupter
  include Singleton

  def initialize
    @errors_count = 0
    @last         = Time.new(1970)
  end

  attr_reader :errors_count, :last, :now

  def perform
    # OPTIMIZE: better way to omit #perform in test environment
    return if ENV['RAILS_ENV'] == 'test'

    now = Time.now
    sleep(time_to_sleep(now))
    @last = now

    nil
  end

  def signal_error
    @errors_count += 1
  end

  def signal_success
    @errors_count = 0
  end

  def multiplier
    calculated_multiplier = 1 + errors_count
    [calculated_multiplier, max_multiplier].min
  end

  def interruption
    min_interruption * multiplier
  end

  def max_multiplier
    5
  end

  def min_interruption
    1
  end

  def time_to_sleep(now)
    CalculateBrainzImportInterruptionService.call(
      last:                last,
      now:                 now,
      needed_interruption: interruption
    )
  end
end
