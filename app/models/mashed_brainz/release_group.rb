module MashedBrainz
  # MusicBrainz release-group
  class ReleaseGroup < Base

    def brainz_id
      BrainzReleaseGroupId.new(value: id)
    end
  end
end
