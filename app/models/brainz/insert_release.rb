module Brainz
  # Insert a MusicBrainz release to the db
  class InsertRelease
    def self.perform(brz_release)
      new(brz_release).perform
    end

    def initialize(brz_release)
      @brz_release = brz_release
    end

    def perform
      artist_credit
      head
      release
      media

      @release
    end

    private

    def artist_credit
      @artist_credit = Brainz::InsertArtistCredit.perform(
        @brz_release.artist_credit
      )
    end

    def head
      @head = @artist_credit.compilations.create!(
        title: @brz_release.title,
        type:  AlbumHead.to_s
      )
    end

    def media
      Brainz::InsertMediaTracks.perform(@brz_release.fill_media, @release)
      # @no = 1
      # @brz_release.fill_media.each do |medium|
      #   medium.sides.each do |side|
      #     insert_side(side)
      #   end
      # end
    end

    def insert_side(side)
      name = side.name
      side.tracks.each do |brz_track|
        #byebug
        brz_recording = brz_track.recording
        # TODO: real ArtistCredit for SongHead
        song_head = SongHead.create!(
          artist_credit: @artist_credit,
          title:         brz_recording.title
        )

        song = song_head.releases.create!(
        )


        t = @release.tracks.create!(
          release: song,
          no:      @no,
        )

        #byebug
      end
    end
    
    def release
      date = IncompleteDate.new(@brz_release.release_group.first_release_date)
      @release = @head.releases.create!(date: date)
    end
  end
end
