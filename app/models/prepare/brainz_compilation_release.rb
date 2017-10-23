module Prepare
  # Prepare a MusicBrainz release to be persisted
  class BrainzCompilationRelease
    attr_reader :cache, :id

    URL_PREFIX = 'https://musicbrainz.org/ws/2/release/'.freeze
    # TODO: add '+url-rels+recording-level-rels' to QUERY_STRING?
    QUERY_STRING = '?inc=artists+labels+recordings+release-groups'.freeze
    attr_reader :params, :cache

    def self.using_id(id, cache)
      new(id, cache).using_id
    end

    def initialize(id, cache)
      @id = id
      @cache = cache
    end

    def using_id
      # TODO: check if the brainz release already exists in the database
      brainz_release = cached_or_require
      if brainz_release
        Import::BrainzArtistCredit.perform(brainz_release.artist_credit, cache)
        # TODO: Use MaschedBrainz if they are available
      end
      # TODO: call `prepare` on related classes
    end

    def cached_or_require
      release_url = brainz_release_url
      xml = cache.fetch_brainz(release_url)
      cache.require_brainz(release_url) unless xml
      return false unless xml
      MashedBrainz::Release.xml(xml)
    end

    def brainz_release_url
      brainz_release_url_for(id)
    end

    def brainz_release_url_for(brainz_id)
      URL_PREFIX + brainz_id + QUERY_STRING
    end
  end
end
