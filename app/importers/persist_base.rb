# frozen_string_literal: true

# Base class for persisting classes
class PersistBase < PersistPrepareBase
  def persist_infix
    raise NoMethodError, "missed to implement #{self.class}#persist_infix"
  end

  def method_missing(method_name, *args)
    klass = persist_class_for(method_name)

    if klass
      klass.call(merge_arguments(args[0]))
    else
      super
    end
  end

  # This method smells of :reek:BooleanParameter
  def respond_to_missing?(method_name, _ = false)
    return true if persist_class_for(method_name)

    false
  end

  private

  def merge_arguments(args = {})
    { import_order: import_order, proxy: proxy }.merge(args)
  end

  def persist_class_for(method_name)
    class_name = persist_class_name_for(method_name) || return

    begin
      class_name.constantize
    rescue NameError => e
      Rails.logger.error(e)
      nil
    end
  end

  def persist_class_name_for(method_name)
    match_data = method_name.match(/\Apersist_(.+)\z/)
    return unless match_data

    "persist_#{persist_infix}_#{match_data[1]}".camelize
  end
end
