# frozen_string_literal: true

# Base-Class for import classes
class ImportBase < ServiceBase
  def initialize(args)
    @import_order = args[:import_order]
  end

  attr_reader :import_order

  def call
    raise ArgumentError, 'invalid ImportOrder' unless import_order.valid?

    existing_one || persisting_one
  end

  def import_request
    @import_request ||= import_request_class.create(
      code:         import_order.code,
      import_order: import_order
    )
  end

  def persist
    proxy.lock

    import_order.transaction do
      # PersistBrainzRelease.call(
      persister_class.call(
        import_order:   import_order,
        import_request: import_request,
        proxy:          proxy
      )
    end
  end

  private

  def existing_one
    result = find_already_existing || prepare

    enhance_result(result, false)
  end

  def import_request_class
    import_order.type.sub(/ImportOrder/, 'ImportRequest').constantize
  end

  def persister_class
    import_order.type.sub(/^(.+)ImportOrder$/, 'Persist\1').constantize
  end

  def persisting_one
    enhance_result(persist, true)
  end

  # This method smells of :reek:UtilityFunction
  def enhance_result(result, created)
    return unless result

    result.define_singleton_method('created?') { created }
    result
  end
end
