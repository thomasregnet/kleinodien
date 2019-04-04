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
    import_order = next_order
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

  # This method smells of :reek:FeatureEnvy
  def next_order
    import_order = import_order_class.constantize.next_pending
    return unless import_order

    import_order.state = :processing
    import_order.save
    import_order
  end

  def subscribe
    # byebug
  end

  def unsubscribe

  end
end
