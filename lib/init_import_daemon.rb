# frozen_string_literal: true

Signal.trap(:INT) do
  exit
end

subscriber = ImportSubscriber.new(
  channel:   ENV['IMPORT_CHANNEL'],
  redis_url: ENV['REDIS_URL'],
  timeout:   ENV['IMPORT_SUBSCRIPTION_TIMEOUT']
)

import_order_class = ENV['IMPORT_ORDER_CLASS'].constantize

ImportDaemon.run(
  import_order_class: import_order_class,
  subscriber:         subscriber
)
