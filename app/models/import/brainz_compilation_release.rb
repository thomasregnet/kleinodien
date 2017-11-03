module Import
  # Post MusicBrainz params to kleinodien
  class BrainzCompilationRelease < Base
    def self.perform(params)
      new(params).perform
    end

    def initialize(args)
      super({ foreign_id_class: BrainzReleaseId }.merge args)

      cache.rebuild_from_params(params)
    end

    def perform
      PrepareBrainzCompilationRelease.using_id(
        cache:      cache,
        foreign_id: foreign_id
      )

      return body if cache.any_required?

      Persist::BrainzCompilationRelease.using_id(foreign_id, cache)

      body
    end

    def body
      wanted_id = wanted
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
