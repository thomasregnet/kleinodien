module Persist
  # Persist a MusicBrainz release-group
  class BrainzCompilationHead
    def self.using_id(foreign_id, cache, artist_credit)
      new(foreign_id, cache, artist_credit).using_id
    end

    def initialize(foreign_id, cache, artist_credit)
      @foreign_id = foreign_id
      @cache         = cache
      @artist_credit = artist_credit
    end

    def using_id; end
  end
end
