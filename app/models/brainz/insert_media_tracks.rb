module Brainz
  # Fill the database with the tracks of on medium received from MusicBrainz
  class InsertMediaTracks
    def self.perform(brz_media, release)
      new(brz_media, release).perform
    end

    def initialize(brz_media, release)
      @brz_media = brz_media
      @release   = release
      @no        = 1
    end

    def perform
      @brz_media.each do |brz_medium|
        perform_medium(brz_medium)
      end
    end

    private

    def perform_medium(brz_medium)
      brz_medium.sides.each do |brz_side|
        perform_side(brz_side)
      end
    end

    def perform_side(brz_side)
      @side_name = brz_side.name
      brz_side.tracks.each do |brz_track|
        perform_brainz_track(brz_track)
      end
    end

    def perform_brainz_track(brz_track)
      piece_release = Brainz::InsertBrainzTrack.perform(
        brz_track, @release.head.artist_credit
      )

      @release.tracks.create!(
        # release: piece_release,
        piece_release: piece_release,
        position:      brz_track.number,
        no:            @no
      )
      @no += 1
    end
  end
end
