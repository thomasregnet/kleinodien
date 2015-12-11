class Discogs::InsertExtraartists
  def self.perform(dc_extraartists, owner)
    new(dc_extraartists, owner).perform
  end

  def initialize(dc_extraartists, owner)
    @dc_extraartists = dc_extraartists
    @owner   = owner
  end

  def perform
    return unless @dc_extraartists
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
    @owner.credits.create!(
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
