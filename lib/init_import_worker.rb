# frozen_string_literal: true

Signal.trap(:INT) do
  exit
end

logger = Rails.logger

import_queue_name = ENV['IMPORT_QUEUE_NAME']

logger.info("starting ImportWorder with queue-name #{import_queue_name}")

subscriber = ImportSubscriber.new(
  channel: import_queue_name,
  timeout: ENV.fetch('IMPORT_SUBSCRIPTION_TIMEOUT', 300).to_i
)

ImportWorker.run(
  import_queue_name: import_queue_name,
  subscriber:        subscriber
)
