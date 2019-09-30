# frozen_string_literal: true

# Choose the right class for MusicBrainz imports and call it
class BrainzImporter
  IMPORTER_FOR = {
    'release' => 'ImportBrainzRelease'
  }.freeze

  def self.call(args)
    new(args).call
  end

  def initialize(import_order:)
    @import_order = import_order
  end

  attr_reader :import_order

  def call
    importer_class.call(import_order: import_order)
  end

  private

  def importer_class
    import_order.type.sub(/\A(.+)ImportOrder\z/, 'Import\1').constantize
  end
end
