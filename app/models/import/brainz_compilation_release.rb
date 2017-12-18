require 'import/find_brainz_release'

module Import
  # Post MusicBrainz params to kleinodien
  class BrainzCompilationRelease < Base
    def self.perform(params)
      new(params).perform
    end

    def initialize(args)
      super({ reference_class: BrainzReleaseReference }.merge args)
    end

    def perform
      return already_exists if find_brainz_release(reference: reference)

      DataImport.transaction do
        prepare_brainz_compilation_release(reference: reference)
        raise ActiveRecord::Rollback, 'data missing' if knowledge.missing?
        persist_brainz_compilation_release(
          data_import: init_data_import,
          reference:   reference
        )
      end

      body
    end

    def already_exists
      {
        data: {
          errors: ['already exists'],
          attributes: { http_status_code: 403 }
        }
      }
    end

    def body
      offered_id = offered
      reference = BrainzReleaseReference.from_code(offered_id)
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

    def init_data_import
      release = ask.brainz.about!(reference)
      note = "MusicBrainz release #{release.title}"
      DataImport.create(note: note)
    end
  end
end
