class Discogs::InsertTracklist
  def self.perform(dc_media, album_release)
    new(dc_media, album_release).perform
  end

  def initialize(dc_media, album_release)
    @dc_media  = dc_media
    @album_release = album_release
  end

  def perform
    tracklist
  end

  private

  def tracklist
    @no = 0
    @dc_media.each do |dc_medium|
      track_or_heading(dc_medium.tracklist)
    end
  end

  def track_or_heading(dc_tracklist)
    dc_tracklist.each do |dc_track|
      if dc_track.class == KleinodienDiscogs::Heading
        @heading = dc_track.title
      else
        track(dc_track)
        @no += 1
      end
    end
  end

  def track(dc_track)
    artist_credit = artist_credit(dc_track.artists)
    song_head = artist_credit.pieces.find_or_create_by!(
      title: dc_track.title,
      type:  SongHead.to_s
    )

    # TODO: deal with song-versions
    song_release = SongRelease.find_or_create_by!(head: song_head)
    # TODO: insert_extraartists
    song_release.tracks.create!(
      compilation: @album_release,
      no:          @no,
      position:    dc_track.position.to_s,
      heading:     @heading
    )
  end

  def artist_credit(artists)
    if artists
      Discog::InsertArtistCredit(artists)
    else
      @album_release.head.artist_credit
    end
  end
end
