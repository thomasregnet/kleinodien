require 'kleinodien_discogs'

class DiscogsImporter
  def self.import_release(json)
    dc_release = KleinodienDiscogs.get_release(json)
    
    artist_credit = import_artist_credit(dc_release.artists)
    album_head = artist_credit.compilations.create!(
      title: dc_release.title,
      type:  'AlbumHead'
    )
    album_release = album_head.releases.create!
    album_release.date = IncompleteDate.new(dc_release.released)
    
    formats = import_formats(dc_release.formats, album_release)

    import_tracks(dc_release.get_media, album_release, formats)
    album_release.save!
    album_release
  end

  def self.import_artist_credit(artists)
    artist_credit = ArtistCredit.new
    artists.each_with_index do |artist, no|
      import_participant(artist, no, artist_credit)
    end
    artist_credit.save!
    artist_credit
  end

  def self.import_participant(dc_artist, no, artist_credit)
    artist = Artist.find_or_create_by(name: dc_artist.name)
    participant = artist_credit.participants.build do |p|
      p.joinparse = dc_artist.join unless dc_artist.join.blank?
      p.no        = no
      p.artist    = artist
    end
  end
  
  def self.import_tracks(dc_media, album_release, formats)
    heading = nil
    dc_media.each do |dc_medium|
      dc_medium.tracklist.each do |dc_track|
        if dc_track.class == KleinodienDiscogs::Heading
          heading = dc_track.title
          next
        else
          artist_credit = dc_track.artists ?
                            import_artist_credit(dc_track.artists) :
                            album_release.head.artist_credit
          song_head = artist_credit.pieces.find_or_create_by!(
            title: dc_track.title,
            type:  'SongHead'
          )

          # TODO: deal with song-versions
          song_release = SongRelease.find_or_create_by!(head: song_head)

          track = song_release.tracks.create!(
            compilation: album_release,
            heading:     heading
          )
        end
        heading = nil
      end
    end
  end
      
  
  def self.import_formats(dc_formats, album_release)
    formats = []
    dc_formats.each_with_index do |f, no|
      f_kind =    CrFormatKind.find_or_create_by!(name: f.name)
      format =    album_release.formats.create!(
        kind:     f_kind,
        note:     f.text,
        quantity: f.qty,
        no:       no
      )
      import_format_attributes(dc_formats[no].descriptions, format)
      formats << format
    end
    formats
  end

  def self.import_format_attributes(dc_formats, format)
    dc_formats.each_with_index do |d, no|
      attr_kind = CrfAttributeKind.find_or_create_by!(name: d)
      format.format_attributes.create!(
        no:   no,
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
