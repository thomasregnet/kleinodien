# frozen_string_literal: true

# Persist an ArtistCredit from MusicBrainz
class PersistBrainzArtistCredit
  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @blueprint = args[:blueprint]
    @proxy     = args[:proxy]
  end

  attr_reader :blueprint, :proxy

  def call
    artist_credit = find_already_existing
    return artist_credit if artist_credit

    persist
  end

  def find_already_existing
    ArtistCredit.find_by(name: join_name)
  end

  def persist
    artist_credit = ArtistCredit.create!(name: join_name)

    PersistParticipantsService.call(
      artist_credit: artist_credit,
      artists:       artists,
      join_phrases:  join_phrases
    )
  end

  def join_name
    @join_name ||= blueprint.join_name
  end

  def join_phrases
    @join_phrases ||= blueprint.name_credits.map(&:joinphrase)
  end

  def artists
    @artists ||= blueprint.name_credits.map do |artist|
      import_request = BrainzArtistImportRequest.new(code: artist.brainz_code)
      blueprint = proxy.get(import_request)
      PersistBrainzArtist.call(
        blueprint: blueprint,
        proxy:     proxy
      )
    end
  end
end
