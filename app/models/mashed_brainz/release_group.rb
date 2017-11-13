module MashedBrainz
  # MusicBrainz release-group
  class ReleaseGroup < Base
    def reference
      BrainzReleaseGroupRef.new(code: id)
    end
  end
end
