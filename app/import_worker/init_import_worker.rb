# frozen_string_literal: true

Signal.trap(:INT) do
  exit
end

# Start up the ImportWorker
class InitImportWorker
  def self.call
    new.call
  end

  attr_reader :import_queue_name, :timeout

  def initialize
    @import_queue_name = ENV['IMPORT_QUEUE_NAME']
    raise ArgumentError, 'Environment variable IMPORT_QUEUE_NAME not set' \
      unless import_queue_name

    @timeout = ENV.fetch('IMPORT_SUBSCRIPTION_TIMEOUT', 300).to_i
  end

  def call
    Rails.logger.info(%(starting ImportWorker for queue "#{import_queue_name}"))

    # ImportWorker.run(
    #   import_queue_name:    import_queue_name,
    #   subscription_timeout: timeout
    # )
    import_worker_run
  end

  private

  def import_worker_run
    ImportWorker.run(
      import_queue_name:    import_queue_name,
      subscription_timeout: timeout
    )
  rescue StandardError => e
    Rails.logger.error("Import worker failed: #{e}, #{e.class}")
    Rails.logger.error(e.backtrace.join("\n"))
  end
end
