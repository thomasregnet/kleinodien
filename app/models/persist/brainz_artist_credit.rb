module Persist
  # Persist an artist_credit form MusicBrainz
  class BrainzArtistCredit
    attr_reader :cache, :original

    def self.using_data(original, cache)
      new(original, cache).using_data
    end

    def initialize(original, cache)
      @cache    = cache
      @original = original
    end

    def using_data
      name_credits = original.name_credits.map do |name_credit|
        # BrainzParticipant.using_data(name_credit)
      end
    end
  end
end
