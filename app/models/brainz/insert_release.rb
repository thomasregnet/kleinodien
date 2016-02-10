class Brainz::InsertRelease
  def self.perform(brz_release)
    new(brz_release).perform
  end

  def initialize(brz_release)
    @brz_release = brz_release
  end

  def perform
    artist_credit
  end

  def artist_credit
    artist_credit = @brz_release.artist_credit
    #Brainz::InsertArtistCredit.perform(@brz_release.artist_credit)
  end
end
