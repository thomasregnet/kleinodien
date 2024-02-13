class Import::MusicbrainzArtistCreditAdapter
  def initialize(session, data: nil, **options)
    @session = session
    @data = data
    @options = options
  end

  attr_reader :data, :options, :session

  def model_class = ArtistCredit

  def prepare
    find_existing_artist_credit
  end

  def persist!
    find_existing_artist_credit || create!
  end

  private

  def create!
    model_class.create!(name: name)
    # data.map { |ac_participant| persist_participant(ac_participant) }
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
end
