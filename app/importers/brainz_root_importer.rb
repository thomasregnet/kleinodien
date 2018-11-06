# frozen_string_literal: true

# Choose the right class for MusicBrainz imports and call it
class BrainzRootImporter
  IMPORTER_FOR = {
    'releae' => 'BrainzReleaseImporter'
  }.freeze

  def self.run(import_order)
    importer_class = IMPORTER_FOR[importorder.kind]
    importer_class.call(import_order)
  end
end
