# frozen_string_literal: true

# Persist an ArtistCredit from MusicBrainz
class PersistBrainzArtistCredit < PersistBrainzBase
  def initialize(args)
    super(args)
    @blueprint = args[:blueprint]
  end

  attr_reader :blueprint

  def call
    artist_credit = find_already_existing
    return artist_credit if artist_credit

    persist
  end

  def find_already_existing
    ArtistCredit.find_by(name: blueprint.join_name)
  end

  def persist
    artist_credit = ArtistCredit.create!(
      import_order: import_order,
      name:         blueprint.join_name
    )

    persist_participants(artist_credit)

    artist_credit
  end

  def persist_participants(artist_credit)
    PersistParticipantsService.call(
      artist_credit: artist_credit,
      artists:       artists,
      import_order:  import_order,
      join_phrases:  join_phrases
    )
  end

  def join_phrases
    @join_phrases ||= blueprint.name_credits.map(&:joinphrase)
  end

  def artists
    @artists ||= blueprint.name_credits.map do |name_credit|
      persist_artist(name_credit.artist.brainz_code)
    end
  end

  def persist_artist(brainz_code)
    import_request = BrainzArtistImportRequest.new(code: brainz_code)
    PersistBrainzArtist.call(
      import_request: import_request,
      proxy:          proxy
    )
  end
end
