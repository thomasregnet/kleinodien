module Prepare
  # Prepare a MusicBrainz release to be persisted
  class BrainzCompilationRelease
    attr_reader :cache, :foreign_id

    URL_PREFIX = 'https://musicbrainz.org/ws/2/release/'.freeze
    # TODO: add '+url-rels+recording-level-rels' to QUERY_STRING?
    QUERY_STRING = '?inc=artists+labels+recordings+release-groups'.freeze
    attr_reader :foreign_id, :params, :cache

    def self.using_id(foreign_id, cache)
      new(foreign_id, cache).using_id
    end

    def initialize(foreign_id, cache)
      @foreign_id = foreign_id
      @cache = cache
    end

    def using_id
      # TODO: check if the brainz release already exists in the database
      brainz_release = cached_or_require
      return unless brainz_release
      BrainzArtistCredit.using_data(brainz_release.artist_credit, cache)
      # TODO: Use MaschedBrainz if they are available
      # TODO: call `prepare` on related classes
    end

    def cached_or_require
      # release_url = brainz_release_url
      xml = cache.fetch_brainz(foreign_id) #release_url)
      cache.require_brainz(foreign_id) unless xml #release_url) unless xml
      return false unless xml
      MashedBrainz::Release.xml(xml)
    end

    def brainz_release_url
      brainz_release_url_for(foreign_id.value)
    end

    def brainz_release_url_for(brainz_id)
      URL_PREFIX + brainz_id + QUERY_STRING
    end
  end
end
