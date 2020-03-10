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
end
