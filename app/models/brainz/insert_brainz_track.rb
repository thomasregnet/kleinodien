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
      brz_recording_id = brz_recording.id

      @song_head = SongHead.where(
        'lower(title) = lower(?) and artist_credit_id = ?',
        brz_recording.title,
        artist_credit.id
      ).first

      if !@song_head
        @song_head = SongHead.find_or_create_by!(
          artist_credit: artist_credit,
          title:         brz_recording.title
        )
      end

      perform_song_release
    end

    private

    def reference
      PrReference.create_with_supplier_name!(
        @brz_track.recording.id, 'MusicBrainz'
      )
    end

    def artist_credit
      brz_artist_credit = @brz_track.recording.artist_credit
      # TODO: ArtistCredit of the Recording for SongHead
      # TODO: find better way to determinate if brz_artist_credit is nil
      return @artist_credit unless brz_artist_credit.node
      Brainz::InsertArtistCredit.perform(brz_artist_credit)
    end

    def perform_song_release
      @song_release = @song_head.releases.create!(reference: reference)
    end
  end
end
