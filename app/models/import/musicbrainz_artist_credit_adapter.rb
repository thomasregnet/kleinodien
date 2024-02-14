class Import::MusicbrainzArtistCreditAdapter
  def initialize(session, data: nil, **options)
    @session = session
    @data = data
    @options = options
  end

  attr_reader :data, :options, :session

  def model_class = ArtistCredit

  def prepare
    data.each do |ac_participant|
      build_artist_credit_participant_adapter(ac_participant).prepare
    end

    find_existing_artist_credit
  end

  def persist!
    find_existing_artist_credit || create!
  end

  private

  def create!
    artist_credit = model_class.create!(name: name)
    # data.map { |ac_participant| persist_participant(ac_participant) }
    data.each.with_index(1) do |ac_participant, position|
      build_artist_credit_participant_adapter(ac_participant, artist_credit, position).persist!
    end

    model_class.find(artist_credit.id)
  end

  def find_existing_artist_credit
    model_class.find_by(name: name)
  end

  def name
    tokens = data.map { |ac| [ac.name, ac.joinphrase] }.flatten

    last_token = tokens.pop
    raise "last participant must not contain anything" if last_token.present?

    tokens.join("")
  end

  def build_artist_credit_participant_adapter(ac_participant, artist_credit = nil, position = nil)
    Import::MusicbrainzArtistCreditParticipantAdapter.new(session,
      data: ac_participant, artist_credit: artist_credit, position: position)
  end
end
