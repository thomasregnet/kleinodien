# frozen_string_literal: true

# Import from external sources
class ImportWorker
  def self.run(args)
    new(args).run
  end

  def initialize(import_queue_name:, subscriber:)
    @import_queue_name = import_queue_name
    @subscriber        = subscriber

    raise ArgumentError, "import_queue_name can't be blank" \
      if import_queue_name.blank?
  end

  attr_reader :import_queue_name, :subscriber

  def run
    loop do
      ProcessImportOrders.call(import_queue_name: import_queue_name)
      message = subscriber.perform
      break if message == 'stop'
    end
  end
end
