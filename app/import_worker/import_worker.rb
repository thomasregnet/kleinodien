# frozen_string_literal: true

# Import from external sources
class ImportWorker
  def self.run(args)
    new(args).run
  end

  def initialize(import_queue_name:, subscription_timeout:)
    @import_queue_name    = import_queue_name
    @subscription_timeout = subscription_timeout

    raise ArgumentError, "import_queue_name can't be blank" \
      if import_queue_name.blank?
  end

  attr_reader :import_queue_name, :subscription_timeout

  def run
    loop do
      ProcessImportOrders.call(import_queue_name: import_queue_name)
      message = subscriber.perform
      break if message == 'stop'
    end
  end

  private

  def subscriber
    @subscriber ||= ImportSubscriber.new(
      channel: import_queue_name,
      timeout: subscription_timeout
    )
  end
end
