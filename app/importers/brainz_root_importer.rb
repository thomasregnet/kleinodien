# frozen_string_literal: true

# Choose the right class for MusicBrainz imports and call it
class BrainzRootImporter
  IMPORTER_FOR = {
    'release' => 'ImportBrainzRelease'
  }.freeze

  def self.run(import_order)
    importer_class = IMPORTER_FOR[import_order.kind]
    importer_class.constantize.call(import_order)
  end
end
