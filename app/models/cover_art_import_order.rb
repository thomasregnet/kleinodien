# frozen_string_literal: true

# Base class for CoverArt import orders
class CoverArtImportOrder < ImportOrder
  COVER_ART_IMPORT_QUEUE_NAME = 'cover_art'

  include CodeUuidValidation

  def self.default_import_queue_name
    COVER_ART_IMPORT_QUEUE_NAME
  end
end
