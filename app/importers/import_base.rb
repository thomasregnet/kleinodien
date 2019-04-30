# frozen_string_literal: true

# Base-Class for import classes
class ImportBase < ServiceBase
  def initialize(args)
    @import_order = args[:import_order]
  end

  attr_reader :import_order

  def call
    raise ArgumentError, 'invalid ImportOrder' unless import_order.valid?

    existing_one || persisted_one
  end

  def find_already_existing
    raise NoMethodError,
          "Class #{self.class} does not implement `find_already_existing'"
  end

  def prepare
    raise NoMethodError,
          "Class #{self.class} does not implement `prepare'"
  end

  def persist
    raise NoMethodError,
          "Class #{self.class} does not implement `persist'"
  end

  private

  def existing_one
    result = find_already_existing || prepare

    enhance_result(result, false)
  end

  def persisting_one
    enhance_result(persist, true)
  end

  # This method smells of :reek:UtilityFunction
  def enhance_result(result, created)
    return unless result

    result.define_singleton_method('created?') { created }
  end
end
