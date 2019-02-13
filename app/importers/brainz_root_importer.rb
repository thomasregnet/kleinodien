# frozen_string_literal: true

# Choose the right class for MusicBrainz imports and call it
class BrainzRootImporter
  IMPORTER_FOR = {
    'release' => 'ImportBrainzRelease'
  }.freeze

  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @import_order = args[:import_order]
  end

  attr_reader :import_order

  def call
    importer_class = IMPORTER_FOR[import_order.kind]
    importer_class.constantize.call(import_order: import_order)
  end
end
