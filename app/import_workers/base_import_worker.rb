# frozen_string_literal: true

# Takes ImportOrders from the database and triggers its processing
class BaseImportWorker
  def self.run(args)
    new(args).run
  end

  def initialize(args)
    @import_order_class = args[:import_order_class]
    @importer           = args[:importer]
  end

  attr_reader :importer, :import_order_class

  def run
    import_order = prepare_order
    if import_order
      run_import(import_order)
    else
      subscribe
    end
  end

  def run_import(import_order)
    unsubscribe
    importer.run(import_order)
    run
  end

  def prepare_order
    order = next_pending_order || return
    order.state = :processing
    order.save
    order
  end

  def next_pending_order
    orders = import_order_class.constantize
                               .where(state: 'pending')
                               .order('created_at asc')
                               .limit(1)

    return unless orders

    orders.first
  end

  def subscribe
    # byebug
  end

  def unsubscribe

  end
end
