class Brainz::InsertMediaTracks
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
      perform_track(brz_track)
    end
  end

  def perform_track(brz_track)
    brz_recording = brz_track.recording
    # TODO: real ArtistCredit for SongHead
    song_head = SongHead.create!(
      artist_credit: @release.head.artist_credit,
      title:         brz_recording.title
    )

    song_release = song_head.releases.create!

    @release.tracks.create!(
      release:  song_release,
      no:       @no,
      side:     @side_name,
      position: brz_track.number
    )

    @no += 1
  end
end
