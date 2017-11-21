module Import
  # Post MusicBrainz params to kleinodien
  class BrainzCompilationRelease < Base
    def self.perform(params)
      new(params).perform
    end

    def initialize(args)
      super({ reference_class: BrainzReleaseRef }.merge args)

      #cache.rebuild_from_params(params)
    end

    def perform
      # PrepareBrainzCompilationRelease.using_id(
      #   cache:      cache,
      #   reference: reference
      # )
      prepare_brainz_compilation_release(reference: reference)
      # TODO: respond_to_missing?
      # TODO: respond_to_missing?
      #return body if cache.any_required?
      return body if knowledge.missing?

      #PersistBrainzCompilationRelease.using_id(reference, cache)
      persist_brainz_compilation_release(reference: reference)

      body
    end

    def body
      wanted_id = wanted
      reference = BrainzReleaseRef.new(code: wanted_id)
      #cache.require_brainz(reference)
      ask.brainz.about(reference)
      {
        data:
          {
            attributes: body_attributes
          }
      }
    end

    def body_attributes
      attributes = {http_status_code: 202}.merge(knowledge.collect)
      #attributes[:http_status_code] = 202
      #attributes.merge(knowledge.collect)
      #attributes[:required] = cache.required if cache.any_required?
      attributes
    end
  end
end
