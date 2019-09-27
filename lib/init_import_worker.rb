# frozen_string_literal: true

Signal.trap(:INT) do
  exit
end

logger = Rails.logger

import_order_class = ENV['IMPORT_ORDER_CLASS'].constantize
import_queue_name  = ENV['IMPORT_QUEUE_NAME']

logger.warn(import_order_class.to_s)

subscriber = ImportSubscriber.new(
  channel: import_order_class.publication_channel_name,
  timeout: ENV.fetch('IMPORT_SUBSCRIPTION_TIMEOUT', 300).to_i
)

ImportWorker.run(
  import_order_class: import_order_class,
  import_queue_name:  import_queue_name,
  subscriber:         subscriber
)
