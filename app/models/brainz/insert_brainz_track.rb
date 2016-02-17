module Brainz
  # Insert a MusicBrainz-Track, returns a SongRelease
  class InsertBrainzTrack
    def self.perform(brz_track, artist_credit)
      new(brz_track, artist_credit).perform
    end

    def initialize(brz_track, artist_credit)
      @brz_track     = brz_track
      @artist_credit = artist_credit
    end

    def perform
      brz_recording = @brz_track.recording

      @song_head = SongHead.create!(
        artist_credit: artist_credit,
        title:         brz_recording.title
      )

      perform_song_release
    end

    private

    def artist_credit
      brz_artist_credit = @brz_track.recording.artist_credit
      # TODO: ArtistCredit of the Recording for SongHead
      # TODO: find better way to determinate if brz_artist_credit is nil
      return @artist_credit unless brz_artist_credit.node
      Brainz::InsertArtistCredit.perform(brz_artist_credit)
    end

    def perform_song_release
      @song_release = @song_head.releases.create!
    end
  end
end
