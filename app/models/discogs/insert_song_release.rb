module Discogs
  class InsertSongRelease
    def self.perform(dc_track, artist_credit)
      new(dc_track, artist_credit).perform
    end

    def initialize(dc_track, artist_credit)
      @dc_track      = dc_track
      @artist_credit = artist_credit
    end

    def perform
      song_head = perform_song_head
      SongRelease.find_or_create_by!(head: song_head)
    end

    def perform_song_head
      @song_head = SongHead.where(
        'lower(title) = lower(?) AND artist_credit_id = ?',
        @dc_track.title,
        @artist_credit.id
      ).first
      
      
      return @song_head if @song_head

      @artist_credit.pieces.find_or_create_by!(
        title: @dc_track.title,
        type:  SongHead.to_s
      )
    end
  end
end
