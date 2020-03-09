# frozen_string_literal: true

# Base class for preparing classes
class PrepareBase < PersistPrepareBase
  def call
    prepare
  rescue StandardError => e
    Rails.logger.error(e)
    import_order.failure!
    raise
  end

  def method_missing(method, *args)
    klass = prepare_class_for(method)

    if klass
      klass.call(merge_arguments(args))
    else
      super
    end
  end

  def respond_to_missing?(method_name, _)
    return true if prepare_class_for(method_name)

    false
  end

  private

  def merge_arguments(args)
    { import_order: import_order, proxy: proxy }.merge(args[0])
  end

  def prepare_class_for(method)
    match_data = method.match(/\Aprepare_(.+)\z/)
    return unless match_data

    "prepare_#{prepare_infix}_#{match_data[1]}".camelize.constantize
  end
end
