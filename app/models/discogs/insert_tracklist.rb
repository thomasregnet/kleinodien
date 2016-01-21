class Discogs::InsertTracklist
  def self.perform(dc_media, album_release)
    new(dc_media, album_release).perform
  end

  def initialize(dc_tracklist, album_release)
    @dc_tracklist     = dc_tracklist
    @album_release = album_release
  end

  def perform
    tracklist
    @album_release.save!
  end

  private

  def tracklist
    @no = 0
    @dc_tracklist.each do |dc_track|
      track_or_heading(dc_track)
    end
  end

  def track_or_heading(dc_track)
    if dc_track.heading?
      @heading = dc_track.title
    else
      track(dc_track)
      @no += 1
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
    track = @album_release.tracks.create!(
      release:     song_release,
      no:          @no,
      position:    dc_track.position.to_s,
      heading:     @heading,
      duration:    dc_track.duration
    )
    Discogs::InsertExtraartists.perform(dc_track.extraartists, song_release)
  end

  def artist_credit(artists)
    if artists.length > 0
      Discogs::InsertArtists.perform(artists)
    else
      @album_release.head.artist_credit
    end
  end
end
