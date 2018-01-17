module Import
  # Persist an artist_credit form MusicBrainz
  class PersistBrainzArtistCredit < PersistBase
    def self.perform(args)
      new(args).perform
    end

    def initialize(args)
      super(args)
    end

    def perform
      artist_credit = find_by
      return artist_credit if artist_credit

      create
    end

    def find_by
      ArtistCredit.find_by(name: blueprint.name)
    end

    def create
      artist_credit = ArtistCredit.new(
        data_import: data_import,
        source:      Source::MusicBrainz
      )
      blueprint.name_credits.each_with_index do |blueprint_name_credit, position|
        build_name_credit_on(blueprint_name_credit, artist_credit, position)
      end

      artist_credit.save!
      artist_credit
    end

    def build_name_credit_on(blueprint_name_credit, artist_credit, position)
      artist = persist_brainz_artist(
        reference: blueprint_name_credit.artist.reference
      )
      join_phrase = blueprint_name_credit.joinphrase
      join_phrase&.strip! # if join_phrase
      artist_credit.participants.build(
        artist:      artist,
        join_phrase: join_phrase,
        position:    position
      )
    end
  end
end
