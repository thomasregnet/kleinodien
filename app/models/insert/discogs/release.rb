class Insert::Discogs::Release

  def initialize(dc_release)
    @dc_release = dc_release
  end
  
  def run
    artist_credit = Insert::Discogs::ArtistCredit.new(@dc_release.artists).run
    album_release = insert_album_release(artist_credit)
  end

  def insert_album_release(artist_credit)
    album_head = insert_album_head(artist_credit)
    album_head.releases.create!(
      date: IncompleteDate.new(@dc_release.released)
    )
  end

  def insert_album_head(artist_credit)
    artist_credit.compilations.create!(
      title: @dc_release.title,
      type:  AlbumHead.to_s
    )    
  end
end
