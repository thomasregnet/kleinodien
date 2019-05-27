# frozen_string_literal: true

Signal.trap(:INT) do
  exit
end

logger = Rails.logger

import_order_class = ENV['IMPORT_ORDER_CLASS'].constantize
logger.warn(import_order_class.to_s)

subscriber = ImportSubscriber.new(
  channel: import_order_class.publication_channel_name,
  timeout: ENV.fetch('IMPORT_SUBSCRIPTION_TIMEOUT', 300).to_i
)

ImportDaemon.run(
  import_order_class: import_order_class,
  subscriber:         subscriber
)
