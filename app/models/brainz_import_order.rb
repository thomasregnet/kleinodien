# frozen_string_literal: true

# ImportOrder for MusicBrainz
class BrainzImportOrder < ImportOrder
  BRAINZ_IMPORT_QUEUE_NAME = 'brainz'

  include CodeUuidValidation

  def self.default_import_queue_name
    BRAINZ_IMPORT_QUEUE_NAME
  end

  # See
  # https://stackoverflow.com/questions/4507149/best-practices-to-handle-routes-for-sti-subclasses-in-rails
  def self.model_name
    ImportOrder.model_name
  end
end
