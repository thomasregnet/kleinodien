module MashedBrainz
  class Artist < Base
    def brainz_id
      BrainzArtistId.new(id)
    end

    def source_id
      brainz_id.source_id
    end
  end
end
