class DiscogsImporter
  def self.import_release(json)
    raw_release = JSON.parse(json, symbolize_names: true)

    artist_credit = import_artist_credit(raw_release[:artists])
    album_head = artist_credit.compilations.create!(
      title: raw_release[:title],
      type: 'AlbumHead')
    album_release = album_head.releases.create!
    # TODO: more than one medium
    medium = album_release.media.create!(no: 1)
    # TODO: deal with real section_formats
    format = SectionFormat.find_or_create_by(name: 'CD', abbr: 'CD')
    # TODO: more than one section
    section = medium.sections.create!(no: 1, format: format)

    import_tracks(raw_release[:tracklist], section, artist_credit)
    album_release
  end

  def self.import_artist_credit(raw_artists)
    artist_credit = ArtistCredit.new
    raw_artists.each_with_index do |a, no|
      import_participant(a, no, artist_credit)
    end
    artist_credit.save!
    artist_credit
  end

  def self.import_participant(raw_artist, no, artist_credit)
    artist = Artist.find_or_create_by!(name: raw_artist[:name])
    participant = artist_credit.participants.build do |p|
      p.joinparse = raw_artist[:join] unless raw_artist[:join].blank?
      p.no        = no
      p.artist    = artist
    end
  end

  def self.import_tracks(raw_tracklist, section, fallback_artist_credit)
    raw_tracklist.each do |t|
      unless t[:type_] == 'heading'
        artist_credit = t[:artists] ? import_artist_credit(t[:artist])
                        : fallback_artist_credit
        song_head = artist_credit.pieces.find_or_create_by!(
          title: t[:title],
          type: 'SongHead')
        # TODO: deal with real formats
        format = Format.find_or_create_by(name: 'mp3')
        # TODO: deal with song-versions
        song_release = SongRelease.find_or_create_by!(head: song_head)
        track = song_release.tracks.create!(format: format, section: section)
      end
    end
  end
end
