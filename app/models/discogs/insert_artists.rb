class Discogs::InsertArtists
  def self.perform(artists)
    new(artists).perform
  end

  def initialize(artists)
    @artists = artists
  end

  def perform
    artist_credit
  end

  private
  
  def artist_credit
    ac_name = KleinodienDiscogs.join_artist_names(@artists)
    ArtistCredit.find_by(name: ac_name) || new_artist_credit
  end

  def new_artist_credit
    artist_credit = ArtistCredit.new()
    @artists.each_with_index do |artist, no|
      participant(artist, no, artist_credit)
    end
    artist_credit.save!
    artist_credit
  end
  
  def participant(dc_artist, no, artist_credit)
    artist = Artist.find_or_create_by!(name: dc_artist.name)
    joinparse = dc_artist.join  unless dc_artist.join.blank?
    artist_credit.participants.build(
      artist:    artist,
      joinparse: joinparse,
      no:        no
    )
  end
end
