class Insert::Discogs::Release

  def initialize(dc_release)
    @dc_release = dc_release
  end
  
  def run
    artist_credit = insert_artist_credit(@dc_release.artists)
    album_release = insert_album_release(artist_credit)
  end

  def insert_album_release(artist_credit)
    album_head = artist_credit.compilations.create!(
      title: @dc_release.title,
      type:  AlbumHead.to_s
    )

    album_head.releases.create!(
      date: IncompleteDate.new(@dc_release.released)
    )
  end
  
  def insert_artist_credit(artists)
    ac_name =  KleinodienDiscogs.join_artist_names(artists)
    ArtistCredit.find_by(name: ac_name) || create_artist_credit(artists)
  end

  def create_artist_credit(artists)
    artist_credit = ArtistCredit.new
    artists.each_with_index do |artist, no|
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
