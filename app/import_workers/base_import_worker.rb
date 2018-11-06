# frozen_string_literal: true

class BaseImportWorker
  def self.run(args)
    new(args).run
  end

  def initialize(args)
    @import_order_class = args[:import_order_class]
    @importer_class     = args[:import_service_class]
  end

  attr_reader :importer_class, :import_order_class

  def run
    import_order = next_pending_order
    subscribe unless import_order
    import_order
  end

  def next_pending_order
    orders = import_order_class.where(state: 'pending')
                               .order('created_at asc')
                               .limit(1)
    return unless orders

    orders.first
  end

  def subscribe
  end
end
