# frozen_string_literal: true

# Calculate interruption time to comply with MusicBrainz rate limit
# https://musicbrainz.org/doc/XML_Web_Service/Rate_Limiting
class CalculateBrainzImportInterruptionService < ServiceBase
  def initialize(args)
    @last                = args[:last]
    @now                 = args[:now]
    @needed_interruption = args[:needed_interruption]
  end

  attr_reader :last, :now, :needed_interruption

  def call
    interruption_ends = last + needed_interruption
    return 0 if interruption_ends < now

    interruption_ends - now
  end
end
