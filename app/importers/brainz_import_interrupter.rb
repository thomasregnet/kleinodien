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
    now = Time.now
    sleep_now(now)
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

  def sleep_now(now)
    # OPTIMIZE: better way to omit #perform in test environment
    return if ENV['RAILS_ENV'] == 'test'

    sleep(time_to_sleep(now))
  end

  def time_to_sleep(now)
    interruption_ends = last + interruption
    return 0 if interruption_ends < now

    interruption_ends - now
  end
end
