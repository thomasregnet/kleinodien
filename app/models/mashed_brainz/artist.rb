module MashedBrainz
  class Artist < Base
    def reference
      BrainzArtistReference.from_code(id)
    end
  end
end
