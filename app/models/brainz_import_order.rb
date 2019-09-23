# frozen_string_literal: true

# ImportOrder for MusicBrainz
class BrainzImportOrder < ImportOrder
  BRAINZ_IMPORT_QUEUE_NAME = 'brainz'

  include CodeUuidValidation

  def default_import_queue_name
    BRAINZ_IMPORT_QUEUE_NAME
  end
end
