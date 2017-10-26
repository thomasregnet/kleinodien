module Persist
  class BrainzCompilationRelease
    attr_reader :cache, :id

    def self.using_id(id, cache)
      new(id, cache).using_id
    end

    def initialize(id, cache)
      @id = id
      @cache = cache
    end

    def using_id
      xml = cache.fetch_brainz!(id)
      original = ::MashedBrainz::Release.xml(xml)
      artist_credit = BrainzArtistCredit.using_data(
        original.artist_credit, cache
      )
      byebug
      release_group_fid = BrainzReleaseGroupId.new(
        value: original.release_group.brainz_id
      )
      compilation_head = Persist::CompilationHead.using_id()
    end
  end
end
