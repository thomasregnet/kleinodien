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

    def release
      # TODO: Add IncompleteDate to release
      # date = IncompleteDate.new(@brz_release.release_group.first_release_date)
      @release = @head.releases.create!
    end
  end
end
