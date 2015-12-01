class Discogs::InsertExtraartists
  def self.perform(dc_extraartists, album_release)
    new(dc_extraartists, album_release).perform
  end

  def initialize(dc_extraartists, album_release)
    @dc_extraartists = dc_extraartists
    @album_release   = album_release
  end

  def perform
    extraartists
  end

  private

  def extraartists
    @dc_extraartists.each do |dc_artist|
      artist_credit = artist_credit(dc_artist)
      job           = job(dc_artist.role)
      extraartist(artist_credit, job)
    end
  end

  def extraartist(artist_credit, job)
    @album_release.credits.create!(
      artist_credit: artist_credit,
      job:           job
    )
  end

  def artist_credit(dc_artist)
    Discogs::InsertArtists.perform([dc_artist])
  end

  def job(role)
    Job.find_or_create_by!(name: role)
  end
end
