# frozen_string_literal: true

# Base class for preparing classes
class PrepareBase < PersistPrepareBase
  # rubocop:disable Style/RescueStandardError
  def call
    puts '================================================='
    prepare
  rescue => e
    Rails.logger.error(e)
    import_order.failure!
  end
  # rubocop:enable Style/RescueStandardError
end
