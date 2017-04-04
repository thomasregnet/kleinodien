module MashedBrainz
  # Part of an ArtistCredit
  class NameCredit < Base
    def name
      artist.name
    end

    def stripped_joinphrase
      return unless joinphrase
      joinphrase.strip
    end
  end
end
