# frozen_string_literal: true

# Base-Class for import classes
class ImportBase < ServiceBase
  def initialize(args)
    @import_order = args[:import_order]
  end

  attr_reader :import_order

  def call
    raise ArgumentError, 'invalid ImportOrder' unless import_order.valid?
  end

  def find_already_existing
    raise NotImplementedError,
          "Class #{self.class} does not implement `find_already_existing'"
  end

  def prepare
    raise NotImplementedError,
          "Class #{self.class} does not implement `prepare'"
  end

  def persist
    raise NotImplementedError,
          "Class #{self.class} does not implement `persist'"
  end
end
