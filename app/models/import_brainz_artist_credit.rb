class ImportBrainzArtistCredit
  attr_reader :artist_credit, :cache

  def self.perform(artist_credit, cache)
    new(artist_credit, cache).perform
  end

  def initialize(artist_credit, cache)
    @artist_credit = artist_credit
    @cache         = cache
  end

  def perform
    prepare
  end

  def prepare
  end
end
