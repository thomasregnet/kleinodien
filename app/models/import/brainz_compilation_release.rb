module Import
  # Post MusicBrainz params to kleinodien
  class BrainzCompilationRelease
    attr_reader :cache, :foreign_id, :params

    def self.perform(params)
      new(params).perform
    end

    def initialize(params)
      @params     = params
      @cache      = Cache.new
      @foreign_id = BrainzReleaseId.new(
        value: params[:data][:attributes][:wanted]
      )

      cache.rebuild_from_params(params)
    end

    def perform
      ::Prepare::BrainzCompilationRelease.using_id(foreign_id, cache)

      return body if cache.any_required?

      ::Persist::BrainzCompilationRelease.using_id(foreign_id, cache)

      body
    end

    def body
      wanted_id = params[:data][:attributes][:wanted]
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
