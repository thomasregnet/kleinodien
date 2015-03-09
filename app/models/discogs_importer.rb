class DiscogsImporter
  def self.import_release(json)
    raw_release = JSON.parse(json, symbolize_names: true)

    artist_credit = import_artist_credit(raw_release[:artists])
    album_head = artist_credit.compilations.create!(
      title: raw_release[:title],
      type: 'AlbumHead')
    album_release = album_head.releases.create!

    formats = prepare_media(raw_release[:formats], album_release)

    import_tracks(raw_release[:tracklist], album_release, formats, artist_credit)
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

  def self.import_tracks(
        raw_tracklist, album_release, formats, default_artist_credit)

    heading_idx = -1
    medium      = album_release.media[heading_idx]
    section     = nil
    side        = 'A'
    
    raw_tracklist.each do |t|
      if t[:type_] == 'heading'
        heading_idx += 1
        format       = formats[heading_idx]
        medium       = album_release.media[heading_idx]
        side         = 'A'
        section      = medium.sections.create!(
          format: formats[heading_idx], side: side)
        next
      end

      m = /^([AB])-(\d+)$/.match(t[:position])
      if m
        side = m[1]
        if side == 'B' && section.side == 'A'
          section = medium.sections.create!(
            format: formats[heading_idx], side: side)
        end
      end
      
      artist_credit = t[:artists] ? import_artist_credit(t[:artist])
                      : default_artist_credit
      song_head = artist_credit.pieces.find_or_create_by!(
        title: t[:title],
        type: 'SongHead')
      # TODO: deal with real formats
      track_format = Format.find_or_create_by(name: 'mp3')
      # TODO: deal with song-versions
      song_release = SongRelease.find_or_create_by!(head: song_head)
      track = song_release.tracks.create!(
        format: track_format, section: section)
    end
  end

  def self.prepare_media(raw_formats, album_release)
    formats = []
    no    = 1
    raw_formats.each do |f|
      next if f[:name] == 'All Media'
      format_name = f[:name]
      qty = f[:qty].to_i
      qty.times do
        album_release.media.create!(no: no)
        no += 1
      end
      qty.times do
        formats << SectionFormat.find_or_create_by!(
        name: format_name, abbr: format_name)
      end
    end
    formats
  end
end
