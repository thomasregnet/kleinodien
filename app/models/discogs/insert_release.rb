class Discogs::InsertRelease

  def self.perform(dc_release)
    new(dc_release).perform
  end

  def initialize(dc_release)
    @dc_release = dc_release
  end
  
  def perform
    @artist_credit = insert_artist_credit
    album_head
    @release = @album_head.releases.create!(
      date: IncompleteDate.new(@dc_release.released)
    )
  end

  private

  def album_head
    @album_head = @artist_credit.compilations.create!(
      title: @dc_release.title,
      type:  AlbumHead.to_s
    )

  end
  # TODO: Refactor following to own class
  def insert_artist_credit
    ac_name =  KleinodienDiscogs.join_artist_names(@dc_release.artists)
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
