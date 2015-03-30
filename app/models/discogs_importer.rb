class DiscogsImporter
  def self.import_release(json)
    raw_release = JSON.parse(json, symbolize_names: true)

    artist_credit = import_artist_credit(raw_release[:artists])
    album_head = artist_credit.compilations.create!(
      title: raw_release[:title],
      type: 'AlbumHead')
    album_release = album_head.releases.create!
    album_release.date = IncompleteDate.new(raw_release[:released])
    
    #formats = prepare_media(raw_release[:formats], album_release)
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

  # def self.import_tracks(raw_tracklist, album_release, formats)

  #   heading_idx = raw_tracklist[0][:type_] == 'heading' ? -1 : 0
  #   medium      = album_release.media.first
  #   section     = nil
  #   side        = 'A'
  #   last_side   = 'A'
    
  #   raw_tracklist.each do |t|
  #     if t[:type_] == 'heading'
  #       heading_idx += 1
  #       medium       = album_release.media[heading_idx]
  #       side         = 'A'
  #       section      = medium.sections.create!(
  #         format: formats[heading_idx], side: side)
  #       next
  #     end

  #     unless section
  #       section = medium.sections.create!(
  #         format: formats[heading_idx], side: side)
  #     end

  #     m = /^([A-Z])-?(\d+)$/.match(t[:position])
  #     if m
  #       side = m[1]
  #       if side != last_side
  #         last_side = side
  #         if section.side == 'A'
  #           section = medium.sections.create!(
  #             format: formats[heading_idx], side: 'B')
  #         else
  #           heading_idx += 1
  #           medium = album_release.media[heading_idx]
  #           section = medium.sections.create!(
  #             format: formats[heading_idx], side: 'A')
  #         end
  #       end
  #     end
      
  #     artist_credit = t[:artists] ? import_artist_credit(t[:artist])
  #                     : album_release.head.artist_credit    
  #     song_head = artist_credit.pieces.find_or_create_by!(
  #       title: t[:title],
  #       type: 'SongHead')

  #     track_format = track_format_for(formats[heading_idx])
  #     # TODO: deal with song-versions
  #     song_release = SongRelease.find_or_create_by!(head: song_head)
  #     track = song_release.tracks.create!(
  #       format: track_format, section: section)
  #   end
  # end

  def self.import_tracks(raw_tracklist, album_release, formats)
    raw_tracklist.each_with_index do |t, idx|
      # TODO: handle track headings
      next if t[:type_] == 'heading'

      artist_credit = t[:artists] ? import_artist_credit(t[:artist])
                      : album_release.head.artist_credit    
      song_head = artist_credit.pieces.find_or_create_by!(
        title: t[:title],
        type: 'SongHead')

      #track_format = track_format_for(formats[heading_idx])
      # TODO: deal with song-versions
      song_release = SongRelease.find_or_create_by!(head: song_head)
      # track = song_release.tracks.create!(
      #   format: track_format, section: section)
      track = song_release.tracks.create!(
        compilation: album_release
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
      format_kind = FormatKind.find_or_create_by!(
        type: 'FormatKind',
        name: f[:name]
      )
      format = album_release.formats.create(
        format_kind:     format_kind,
        quantity: f[:qty],
        no:       idx
      )
      formats << format
    end
    formats
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
