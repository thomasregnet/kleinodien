module Import
  # Persist an artist_credit form MusicBrainz
  class PersistBrainzArtistCredit < PersistBase
    def self.using_data(args)
      new(args).using_data
    end

    def initialize(args)
      super(args)
    end

    def using_data
      artist_credit = find_by
      return artist_credit if artist_credit

      create
    end

    def find_by
      ArtistCredit.find_by(name: template.name)
    end

    def create
      artist_credit = ArtistCredit.new(source: Source::MusicBrainz)
      template.name_credits.each_with_index do |template_name_credit, position|
        build_name_credit_on(template_name_credit, artist_credit, position)
      end

      artist_credit.save!
      artist_credit
    end

    def build_name_credit_on(template_name_credit, artist_credit, position)
      artist = PersistBrainzArtist.using_id(
        foreign_id: template_name_credit.artist.brainz_id,
        cache: cache
      )
      join_phrase = template_name_credit.joinphrase
      join_phrase.strip! if join_phrase
      artist_credit.participants.build(
        artist:      artist,
        join_phrase: join_phrase,
        position:    position
      )

    end
  end
end
