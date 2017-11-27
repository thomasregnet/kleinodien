module Import
  # Post MusicBrainz params to kleinodien
  class BrainzCompilationRelease < Base
    def self.perform(params)
      new(params).perform
    end

    def initialize(args)
      super({ reference_class: BrainzReleaseRef }.merge args)
    end

    def perform
      DataImport.transaction do
        prepare_brainz_compilation_release(reference: reference)
        raise ActiveRecord::Rollback, 'data missing' if knowledge.missing?
        persist_brainz_compilation_release(reference: reference)
      end

      body
    end

    def body
      wanted_id = wanted
      reference = BrainzReleaseRef.new(code: wanted_id)
      ask.brainz.about(reference)
      {
        data:
          {
            attributes: body_attributes
          }
      }
    end

    def body_attributes
      attributes = { http_status_code: 202 }.merge(knowledge.collect)
      # attributes[:http_status_code] = 202
      # attributes.merge(knowledge.collect)
      # attributes[:required] = cache.required if cache.any_required?
      attributes
    end
  end
end
