# frozen_string_literal: true

# Calls the right importer for an ImportOrder
class DeliverImportOrderService < ServiceBase
  def initialize(args)
    @import_order = args[:import_order]
  end

  attr_reader :import_order

  def call
    importer_class.call(import_order: import_order)
  end

  private

  def importer_class
    import_order_class_name = import_order.class.to_s
    class_name = import_order_class_name.gsub(/ImportOrder$/, 'Importer')
    class_name.constantize
  end
end
