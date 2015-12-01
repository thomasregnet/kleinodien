class Discogs::InsertRelease

  def self.perform(dc_release)
    new(dc_release).perform
  end

  def initialize(dc_release)
    @dc_release = dc_release
  end

  def perform
    artist_credit
    album_head
    @album_release = @album_head.releases.create!(
      date: IncompleteDate.new(@dc_release.released)
    )
    formats
    country
    companies
    labels
    @album_release
  end

  private

  def artist_credit
    @artist_credit = Discogs::InsertArtists.perform(@dc_release.artists)
  end

  def album_head
    @album_head = @artist_credit.compilations.create!(
      title: @dc_release.title,
      type:  AlbumHead.to_s
    )
  end

  def companies
    Discogs::InsertCompanies.perform(@dc_release.companies, @album_release)
  end

  def country
    country = Country.find_or_create_by!(name: @dc_release.country)
    @album_release.countries << country
  end

  def formats
    Discogs::InsertFormats.perform(@dc_release.formats, @album_release)
  end

  def labels
    Discogs::InsertLabels.perform(@dc_release.labels, @album_release)
  end
end
