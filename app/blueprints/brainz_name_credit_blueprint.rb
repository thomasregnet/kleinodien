# Part of an ArtistCredit
class BrainzNameCreditBlueprint < BrainzBaseBlueprint
  def name
    artist.name
  end

  def stripped_joinphrase
    return unless joinphrase
    joinphrase.strip
  end
end
