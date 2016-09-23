module Discogs
  # Insert a Discogs Album-Release
  class InsertRelease
    def self.perform(dc_release)
      new(dc_release).perform
    end

    def initialize(dc_release)
      @dc_release = dc_release
    end

    def perform
      return if already_exists?
      artist_credit
      album_head
      album_release
      extraartists
      formats
      country
      companies
      identifiers
      labels
      songs

      @album_release.save! # important
      @album_release
    end

    private

    def already_exists?
      #AlbumRelease.with_discogs_id_exists? @dc_release.id
      AlbumRelease.find_by(
        source_name: Source::Discogs.name,
        source_ident: @dc_release.id
      )
    end

    def album_release
      @album_release = @album_head.releases.create!(
        date:      IncompleteDate.from_string(@dc_release.released),
        source_name: Source::Discogs.name,
        source_ident: @dc_release.id
      )
    end

    def artist_credit
      @artist_credit = Discogs::InsertArtists.perform(@dc_release.artists)
    end

    def album_head
      @album_head = find_album_head || create_album_head
    end

    def find_album_head
      AlbumHead.find_by(
        source_name: Source::Discogs.name,
        source_ident: @dc_release.master_id
      )
    end

    def create_album_head
      @artist_credit.compilations.create!(
        title: @dc_release.title,
        type:  AlbumHead.to_s,
        source_name: Source::Discogs.name,
        source_ident: @dc_release.master_id
      )
    end

    def companies
      Discogs::InsertCompanies.perform(@dc_release.companies, @album_release)
    end

    def country
      country = Country.find_or_create_by!(name: @dc_release.country)
      @album_release.countries << country
    end

    def extraartists
      Discogs::InsertExtraartists.perform(
        @dc_release.extraartists,
        @album_release
      )
    end

    def formats
      Discogs::InsertFormats.perform(@dc_release.formats, @album_release)
    end

    def identifiers
      Discogs::InsertIdentifiers.perform(
        @dc_release.identifiers,
        @album_release
      )
    end

    def labels
      Discogs::InsertLabels.perform(@dc_release.labels, @album_release)
    end

    def songs
      Discogs::InsertSongs.perform(@dc_release.fill_media, @album_release)
    end
  end
end
