module Import
  class MusicbrainzArtistCreditParticipantAdapter
    def initialize(session, data: nil, **options)
      @session = session
      @data = data
      @options = options
    end

    attr_reader :data, :options, :session

    def model_class = ArtistCreditParticipant

    def prepare
    end

    def persist!
      # participant
      model_class.create!(
        artist_credit: artist_credit,
        join_phrase: data.joinphrase,
        participant: participant,
        position: options[:position]
      )
    end

    private

    def artist_credit
      options[:artist_credit]
    end

    def participant
      participant_adapter = Import::MusicbrainzParticipantAdapter.new(
        session,
        # code: data.artist.code
        data: data.artist
      )

      participant_adapter.prepare || participant_adapter.persist!
    end
  end
end
