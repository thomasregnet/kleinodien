class Brainz::InsertArtistCredit
  def self.perform(brz_artist_credit)
    new(brz_artist_credit).perform
  end

  def initialize(brz_artist_credit)
    @brz_artist_credit = brz_artist_credit
  end

  def perform
    ac_name = @brz_artist_credit.joined_artists
    ArtistCredit.find_by(name: ac_name) || create_artist_credit
  end

  private
  
  def create_artist_credit
    @artist_credit = ArtistCredit.new
    @brz_artist_credit.name_credits.each_with_index do |brz_name_credit, no|
      participant(brz_name_credit, no)
    end
    @artist_credit.save!
    @artist_credit
  end

  def participant(brz_name_credit, no)
    brz_artist = brz_name_credit.artist
    artist = Artist.where('lower(name) = ?', brz_artist.name.downcase).first
    artist = Artist.create!(name: brz_artist.name) unless artist

    join_phrase = brz_name_credit.joinphrase
    @artist_credit.participants.build(
      artist:      artist,
      join_phrase: join_phrase,
      no:          no
    )
  end
end
