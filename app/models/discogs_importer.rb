require 'kleinodien_discogs'

# Import data from Discogs
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
    import_country(dc_release.country, album_release)
    import_extraartists(dc_release.extraartists, album_release)
    import_identifiers(dc_release.identifiers, album_release)
    import_labels(dc_release.labels, album_release)
    import_tracks(dc_release.get_media, album_release)
    album_release.save!
    album_release
  end

  def self.import_extraartists(extraartists, release)
    return unless extraartists
    extraartists.each do |artist|
      artist_credit = import_artist_credit([artist])
      release.credits.create!(
        artist_credit: artist_credit,
        job: Job.find_or_create_by!(name: artist.role),
      )
    end
  end

  def self.import_identifiers(dc_identifiers, album_release)
    return unless dc_identifiers
    dc_identifiers.each do |dc_id|
      identifier_type = import_identifier_type(dc_id.type)
      album_release.identifiers.create!(
        code:           dc_id.value,
        type:           identifier_type,
        disambiguation: dc_id.description,
      )
    end
  end

  def self.import_identifier_type(name)
    IdentifierType.find_or_create_by!(name: name)
  end

  def self.import_country(country_name, album_release)
    country = Country.find_or_create_by!(name: country_name)
    album_release.countries << country
  end

  def self.import_labels(dc_labels, album_release)
    role = CompanyRole.find_or_create_by!(name: 'Label')

    dc_labels.each do |dc_label|
      company = Company.find_or_create_by!(name: dc_label.name)
      album_release.companies.create!(
        company: company,
        company_role: role,
        catalog_no: dc_label.catno
      )
    end
  end

  def self.import_artist_credit(artists)
    ac_name = KleinodienDiscogs.join_artist_names(artists)
    ArtistCredit.find_by(name: ac_name) || create_artist_credit(artists)
  end

  def self.create_artist_credit(artists)
    artist_credit = ArtistCredit.new
    artists.each_with_index do |artist, no|
      import_participant(artist, no, artist_credit)
    end
    artist_credit.save!
    artist_credit
  end

  def self.import_participant(dc_artist, no, artist_credit)
    artist = Artist.find_or_create_by!(name: dc_artist.name)
    joinparse = dc_artist.join  unless dc_artist.join.blank?
    artist_credit.participants.build(
      artist:    artist,
      joinparse: joinparse,
      no:        no
    )
  end

  def self.import_tracks(dc_media, album_release)
    no      = 0
    heading = nil
    dc_media.each do |dc_medium|
      dc_medium.tracklist.each do |dc_track|
        if dc_track.class == KleinodienDiscogs::Heading
          heading = dc_track.title
          next
        else
          import_track(dc_track, album_release, no, heading)
          no += 1
        end
        heading = nil
      end
    end
  end

  def self.import_track(dc_track, album_release, no, heading)
    artist_credit = dc_track.artists ?
                      import_artist_credit(dc_track.artists) :
                      album_release.head.artist_credit
    song_head = artist_credit.pieces.find_or_create_by!(
      title: dc_track.title,
      type:  'SongHead'
    )

    # TODO: deal with song-versions
    song_release = SongRelease.find_or_create_by!(head: song_head)
    import_extraartists(dc_track.extraartists, song_release)
    track = song_release.tracks.create!(
      compilation: album_release,
      no:          no,
      position:    dc_track.position.to_s,
      heading:     heading
    )
  end

  def self.import_formats(dc_formats, album_release)
    dc_formats.each_with_index.map do |dc_format, no|
      format = album_release.formats.create!(
        kind:     CrFormatKind.find_or_create_by!(name: dc_format.name),
        note:     dc_format.text,
        quantity: dc_format.qty,
        no:       no
      )
      import_format_attributes(dc_formats[no].descriptions, format)
    end
  end

  def self.import_format_attributes(dc_formats, format)
    dc_formats.each_with_index do |dc_format_name, no|
      attr_kind = CrfAttributeKind.find_or_create_by!(name: dc_format_name)
      format.format_attributes.create!(
        no:   no,
        kind: attr_kind
      )
    end
  end

  def self.track_format_for(medium_format)
    case medium_format.name
    when 'CD'
      Format.find_or_create_by!(name: 'CD-DA')
    when 'Vinyl'
      Format.find_or_create_by!(name: 'Analog Audio')
    else
      nil
    end
  end
end
