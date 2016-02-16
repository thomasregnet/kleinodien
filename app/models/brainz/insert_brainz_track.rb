class Brainz::InsertBrainzTrack
  def self.perform(brz_track, release, no, side_name)
    new(brz_track, release, no, side_name).perform
  end

  def initialize(brz_track, release, no, side_name)
    @brz_track = brz_track
    @release   = release
    @no        = no
    @side_name = side_name
  end

  def perform
    brz_recording = @brz_track.recording
    # TODO: real ArtistCredit for SongHead
    @song_head = SongHead.create!(
      artist_credit: @release.head.artist_credit,
      title:         brz_recording.title
    )

    perform_song_release
    t = @release.tracks.create!(
      release:  @song_release,
      no:       @no,
      side:     @side_name,
      position: @brz_track.number
    )

    #byebug
  end

  private

  def perform_song_release
    @song_release = @song_head.releases.create!
  end
end
