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
    ArtistCredit.find_by(name: ac_name)
  end

  def persist
    artist_credit = ArtistCredit.create!(name: ac_name)

    artists.each_with_index do |artist, position|
      Participant.create!(
        artist:        artist,
        artist_credit: artist_credit,
        join_phrase:   join_phrases[position],
        position:      position
      )
    end
  end

  def ac_name
    @ac_name ||= JoinBrainzArtistCreditService.call(blueprint: blueprint)
  end

  def join_phrases
    @join_phrases ||= blueprint.name_credits.map(&:joinphrase)
  end

  def artists
    blueprint.name_credits.map do |artist|
      import_request = BrainzArtistImportRequest.new(code: artist.brainz_code)
      blueprint = proxy.get(import_request)
      PersistBrainzArtist.call(
        blueprint: blueprint,
        proxy:     proxy
      )
    end
  end
end
