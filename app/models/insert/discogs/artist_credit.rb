class Insert::Discogs::ArtistCredit

  def initialize(dc_artists)
    @dc_artists = dc_artists
  end

  def run
    insert_artist_credit
  end

  def insert_artist_credit
    ac_name =  KleinodienDiscogs.join_artist_names(@dc_artists)
    ::ArtistCredit.find_by(name: ac_name) || create_artist_credit
  end

  def create_artist_credit
    artist_credit = ArtistCredit.new
    @dc_artists.each_with_index do |artist, no|
      insert_participant(artist, no, artist_credit)
    end
    artist_credit.save!
    artist_credit
  end

  def insert_participant(dc_artist, no, artist_credit)
    artist = Artist.find_or_create_by!(name: dc_artist.name)
    joinparse = dc_artist.join  unless dc_artist.join.blank?
    artist_credit.participants.build(
      artist:    artist,
      joinparse: joinparse,
      no:        no
    )
  end
end
