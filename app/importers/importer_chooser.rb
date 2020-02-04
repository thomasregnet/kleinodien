# frozen_string_literal: true

# Choose the right Importer
class ImporterChooser < ServiceBase
  def initialize(import_order:)
    @import_order = import_order
  end

  attr_reader :import_order

  def call
    importer_class.call(import_order: import_order)
  end

  private

  def importer_class
    class_name = import_order.type.sub(/\A(.+)ImportOrder\z/, 'Import\1')
    Rails.logger.info("importer-class is #{class_name}")

    class_name.constantize
  end
end
