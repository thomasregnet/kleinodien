module Brainz
  # Insert a song from MusicBrainz
  class InsertPieceRelease
    def self.perform(brz_release, release)
      new(brz_release, release).perform
    end

    def initialize(brz_release, release)
      @brz_release = brz_release
      @release     = release
    end

    def perform
    end
  end
end
