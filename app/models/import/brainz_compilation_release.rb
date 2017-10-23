module Import
  # Post MusicBrainz params to kleinodien
  class BrainzCompilationRelease
    URL_PREFIX = 'https://musicbrainz.org/ws/2/release/'.freeze
    # TODO: add '+url-rels+recording-level-rels' to QUERY_STRING?
    QUERY_STRING = '?inc=artists+labels+recordings+release-groups'.freeze
    attr_reader :params, :cache

    def self.perform(params)
      new(params).perform
    end

    def initialize(params)
      @params = params
      #@cache  = Import::Cache.new
      @cache = Cache.new
    end

    def perform
      prepare
      body
    end

    def body
      wanted_id = params[:data][:attributes][:wanted]
      brainz_id = BrainzReleaseId.new(wanted_id)
      cache.require_brainz(brainz_id.source_id)
      {
        data:
          {
            attributes: body_attributes
          }
      }
    end

    def body_attributes
      attributes = {}
      attributes[:http_status_code] = 202
      attributes[:required] = cache.required if cache.any_required?
      attributes
    end

    def prepare
      cache.rebuild_from_params(params)
      # TODO: check if the brainz release already exists in the database
      brainz_release = cached_or_require
      if brainz_release
        ImportBrainzArtistCredit.perform(brainz_release.artist_credit, cache)
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
      brainz_release_url_for(params[:data][:attributes][:wanted])
    end

    def brainz_release_url_for(brainz_id)
      URL_PREFIX + brainz_id + QUERY_STRING
    end
  end
end
