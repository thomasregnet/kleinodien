module Discogs
  # Insert songs of a discogs release
  class InsertSongs
    def self.perform(media, album_release)
      new(media, album_release).perform
    end

    def initialize(media, album_release)
      @media         = media
      @album_release = album_release
      @position      = 0
    end

    def perform
      @media.each do |medium|
        perform_medium(medium)
      end
    end

    def perform_medium(medium)
      medium.sides.each do |side|
        perform_side(side)
      end
    end

    def perform_side(side)
      @side_name = side.name
      side.tracks.each do |dc_track|
        track_or_heading(dc_track)
      end
    end

    def track_or_heading(dc_track)
      if dc_track.heading?
        @heading = dc_track.title
      else
        track(dc_track)
        @position += 1
      end
    end

    def track(dc_track)
      artist_credit = artist_credit(dc_track.artists)
      # TODO: deal with song-versions
      song_release = Discogs::InsertSongRelease.perform(
        dc_track,
        artist_credit
      )
      track_create(dc_track, song_release)
      @heading = nil
      Discogs::InsertExtraartists.perform(dc_track.extraartists, song_release)
    end

    def track_create(dc_track, song_release)
      @album_release.tracks.create!(
        # release:     song_release,
        piece_release: song_release,
        position:      @position,
        location:      dc_track.position.to_s,
        heading:       @heading,
        duration:      dc_track.duration,
        side:          @side_name
      )
    end

    def artist_credit(artists)
      if !artists.empty?
        Discogs::InsertArtists.perform(artists)
      else
        @album_release.head.artist_credit
      end
    end
  end
end
