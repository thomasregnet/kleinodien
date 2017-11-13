module MashedBrainz
  class Artist < Base
    def reference
      BrainzArtistRef.new(code: id)
    end
  end
end
