module Import
  # Persist an artist_credit form MusicBrainz
  class PersistBrainzArtistCredit
    attr_reader :cache, :original

    def self.using_data(original, cache)
      new(original, cache).using_data
    end

    def initialize(original, cache)
      @cache    = cache
      @original = original
    end

    def using_data
      artist_credit = ArtistCredit.new(source: Source::MusicBrainz)
      original.name_credits.each_with_index do |original_name_credit, position|
        build_name_credit_on(original_name_credit, artist_credit, position)
      end

      artist_credit.save!
      artist_credit
    end

    def build_name_credit_on(original_name_credit, artist_credit, position)
      artist = PersistBrainzArtist.using_id(
        original_name_credit.artist.brainz_id, cache
      )
      join_phrase = original_name_credit.joinphrase
      join_phrase.strip! if join_phrase
      artist_credit.participants.build(
        artist:      artist,
        join_phrase: join_phrase,
        position:    position
      )

    end
  end
end
