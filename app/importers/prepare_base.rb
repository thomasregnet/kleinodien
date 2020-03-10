# frozen_string_literal: true

# Base class for preparing classes
class PrepareBase < PersistPrepareBase
  include PersistablePrepareable

  def call
    prepare
  rescue StandardError => e
    Rails.logger.error(e)
    import_order.failure!
    raise
  end

  # def prepare_infix
  #   raise NoMethodError, "missed to implement #{self.class}#prepare_infix"
  # end

  # def method_missing(method_name, *args)
  #   klass = prepare_class_for(method_name)

  #   if klass
  #     klass.call(merge_arguments(args[0]))
  #   else
  #     super
  #   end
  # end

  # # This method smells of :reek:BooleanParameter
  # def respond_to_missing?(method_name, _ = false)
  #   return true if prepare_class_for(method_name)

  #   false
  # end

  # private

  # def merge_arguments(args = {})
  #   { import_order: import_order, proxy: proxy }.merge(args)
  # end

  # def prepare_class_for(method_name)
  #   class_name = prepare_class_name_for(method_name) || return

  #   begin
  #     class_name.constantize
  #   rescue NameError => e
  #     Rails.logger.error(e)
  #     nil
  #   end
  # end

  # def prepare_class_name_for(method_name)
  #   match_data = method_name.match(/\Aprepare_(.+)\z/)
  #   return unless match_data

  #   "prepare_#{prepare_infix}_#{match_data[1]}".camelize
  # end
end
