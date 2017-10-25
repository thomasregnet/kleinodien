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
      @cache = Cache.new
    end

    def perform
      foreign_id = BrainzReleaseId.new(
        value: params[:data][:attributes][:wanted]
      )
      #byebug
      cache.rebuild_from_params(params)
      ::Prepare::BrainzCompilationRelease.using_id(
        foreign_id,
        cache
      )
      ::Persist::BrainzCompilationRelease.using_id(
        foreign_id,
        cache
      )
      body
    end

    def body
      wanted_id = params[:data][:attributes][:wanted]
      #brainz_id = BrainzReleaseId.new(value: wanted_id)
      brainz_id = BrainzReleaseId.new(value: wanted_id)
      cache.require_brainz(brainz_id)
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
  end
end
