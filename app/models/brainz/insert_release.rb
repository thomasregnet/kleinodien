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
      @head = AlbumHead.find_by_reference(
        @brz_release.release_group.id, 'MusicBrainz'
      ) && return

      @head = @artist_credit.compilations.create!(
        title:     @brz_release.title,
        type:      AlbumHead.to_s,
        reference: create_head_reference
      )
    end

    def create_head_reference
      ChReference.create_with_supplier_name!(
        @brz_release.release_group.id, 'MusicBrainz'
      )
    end
    
    def media
      Brainz::InsertMediaTracks.perform(@brz_release.fill_media, @release)
    end

    def release
      date = IncompleteDate.new(@brz_release.release_group.first_release_date)
      @release = @head.releases.create!(
        date:      date,
        reference: create_release_reference
      )
    end

    def create_release_reference
      CrReference.create_with_supplier_name!(
        @brz_release.id, 'MusicBrainz'
      )      
    end
  end
end
