class DiscogsImporter
  def self.import_release(json)
    raw_release = JSON.parse(json, symbolize_names: true)

    artist_credit = import_artist_credit(raw_release[:artists])
    album_head = artist_credit.compilations.create!(
      title: raw_release[:title],
      type: 'AlbumHead')
    album_release = album_head.releases.create!
    album_release.date = IncompleteDate.new(raw_release[:released])
    
    formats = import_formats(raw_release[:formats], album_release)
    
    import_tracks(raw_release[:tracklist], album_release, formats)
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

  def self.import_tracks(raw_tracklist, album_release, formats)
    heading = nil
    raw_tracklist.each_with_index do |t, idx|
      if t[:type_] == 'heading'
        heading = t[:title]
        next
      end
      artist_credit = t[:artists] ? import_artist_credit(t[:artist])
                      : album_release.head.artist_credit    
      song_head = artist_credit.pieces.find_or_create_by!(
        title: t[:title],
        type: 'SongHead')

      # TODO: deal with song-versions
      song_release = SongRelease.find_or_create_by!(head: song_head)

      track = song_release.tracks.create!(
        compilation: album_release,
        heading:     heading,
      )
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

  def self.import_formats(raw_formats, album_release)
    formats = []
    raw_formats.each_with_index do |f, idx|
      f_kind = CrFormatKind.find_or_create_by!(name: f[:name])
      format = album_release.formats.create(
        kind:     f_kind,
        quantity: f[:qty],
        no:       idx
      )
      #byebug
      import_format_attributes(raw_formats[idx][:descriptions], format)
      formats << format
    end
    formats
  end

  def self.import_format_attributes(raw_descriptions, format)
    raw_descriptions.each_with_index do |d, idx|
      attr_kind = CrfAttributeKind.find_or_create_by!(name: d)
      format.format_attributes.create!(
        no: idx,
        kind: attr_kind
      )
    end
  end
  
  def self.track_format_for(medium_format)
    format = nil
    if medium_format.name == 'CD'
      format = Format.find_or_create_by!(name: 'CD-DA')
    elsif medium_format.name == 'Vinyl'
      format = Format.find_or_create_by!(name: 'Analog Audio')
    end
    format
  end
end
