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
      brz_id = @brz_release.release_group.id
      ref = AlbumHead.with_id_from_data_supplier(brz_id, 'MusicBrainz')
      # byebug
      if ref
        @head = ref.compilation_head
        return
      end

      @head = @artist_credit.compilations.create!(
        title:     @brz_release.title,
        type:      AlbumHead.to_s,
        reference: create_head_reference
      )
    end

    def create_head_reference
      release_group_id = @brz_release.release_group.id
      supplier = DataSupplier.find_or_create_by!(name: 'MusicBrainz')
      ChReference.find_or_create_by!(
        supplier: supplier,
        identifier: release_group_id
      )
    end
    
    def media
      Brainz::InsertMediaTracks.perform(@brz_release.fill_media, @release)
    end

    def release
      date = IncompleteDate.new(@brz_release.release_group.first_release_date)
      #byebug
      @release = @head.releases.create!(date: date)
    end
  end
end
