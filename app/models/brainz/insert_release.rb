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
      @head = find_head || create_head
    end

    def find_head
      AlbumHead.find_by(
        source_name: Source::MusicBrainz.name,
        source_ident: @brz_release.release_group.id
      )
    end

    def create_head
      @artist_credit.compilations.create!(
        title:     @brz_release.title,
        type:      AlbumHead.to_s,
        source_name: Source::MusicBrainz.name,
        source_ident: @brz_release.release_group.id
      )
    end

    def media
      Brainz::InsertMediaTracks.perform(@brz_release.fill_media, @release)
    end

    def release
      date = IncompleteDate.from_string(
        @brz_release.release_group.first_release_date
      )
      @release = @head.releases.create!(
        date:      date,
        source_name: Source::MusicBrainz.name,
        source_ident: @brz_release.mbid
      )
    end
  end
end
