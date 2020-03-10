# frozen_string_literal: true

# Implements #method_missing for persist_* and prepare_* methods
module PersistablePrepareable
  extend ActiveSupport::Concern

  def persist_prepare_infix
    raise(
      NoMethodError,
      "missed to implement #{self.class}#persist_prepare_infix"
    )
  end

  def method_missing(method_name, *args)
    klass = class_for(method_name)

    return klass.call(merge_arguments(args[0])) if klass

    super
  end

  # This method smells of :reek:BooleanParameter
  def respond_to_missing?(method_name, _ = false)
    return true if class_for(method_name)

    false
  end

  private

  def merge_arguments(args = {})
    { import_order: import_order, proxy: proxy }.merge(args)
  end

  def class_for(method_name)
    class_name = class_name_for(method_name) || return

    begin
      class_name.constantize
    rescue NameError => e
      Rails.logger.error(e)
      nil
    end
  end

  def class_name_for(method_name)
    match_data = method_name.match(/\A(p[a-z]+)_(.+)\z/)
    return unless match_data

    action, suffix = match_data[1, 2]
    return unless %w[persist prepare].include?(action)

    "#{action}_#{persist_prepare_infix}_#{suffix}".camelize
  end
end
