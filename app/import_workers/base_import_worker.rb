# frozen_string_literal: true

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
    # beyebug
    unless import_order
      subscribe
      return
    end

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
end
