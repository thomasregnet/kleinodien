module Import
  class MusicbrainzArtistCreditParticipantFacade
    include Concerns::Numerable

    def initialize(session, data:, **options)
      @session = session
      @data = data
      @options = options
    end

    attr_reader :data, :options, :session
    alias_method :position, :consecutive_number

    def model_class = ArtistCreditParticipant

    def artist_credit
      options[:artist_credit]
    end

    def join_phrase
      data.joinphrase
    end

    def participant
      session.build_facade(Participant, code: data.artist.id)
    end
  end
end
