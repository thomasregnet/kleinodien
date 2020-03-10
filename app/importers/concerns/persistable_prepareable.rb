# frozen_string_literal: true

# Implements #method_missing for persist_* and prepare_* methods
module PersistablePrepareable
  extend ActiveSupport::Concern

  def prepare_infix
    raise NoMethodError, "missed to implement #{self.class}#prepare_infix"
  end

  def method_missing(method_name, *args)
    klass = class_for(method_name)

    if klass
      klass.call(merge_arguments(args[0]))
    else
      super
    end
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

  # This method smells of :reek:FeatureEnvy
  def class_name_for(method_name)
    match_data = method_name.match(/\A(p[a-z]+)_(.+)\z/)
    return unless match_data
    return unless %w[persist prepare].include?(match_data[1])

    "prepare_#{prepare_infix}_#{match_data[2]}".camelize
  end
end
