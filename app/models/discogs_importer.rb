class DiscogsImporter
  def self.import_release(json)
    raw_release = JSON.parse(json, symbolize_names: true)

    artist_credit = import_artist_credit(raw_release[:artists])
    AlbumRelease.new
  end

  def self.import_artist_credit(raw_artists)
    artist_credit = Artist.new

    raw_artists.each_with_index do |a, no|
      artist = Artist.find_or_create_by!(name: a[:name])
      participant = artist_credit.participants.build do |p|
        p.joinparse = a[:join] unless a[:join].blank?
        p.no        = no
        p.artist    = artist
      end
    end

    artist_credit.save!
    artist_credit
  end
end
