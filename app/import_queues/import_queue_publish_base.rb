# frozen_string_literal: true

# Base class for import queue publications
class ImportQueuePublishBase < ImportQueueBase
  def self.call(message)
    new(message).call
  end

  def self.run
    new(message: 'run').call
  end

  def initialize(args)
    @message = args[:message]
  end

  attr_reader :message

  def call
    connection.start
    exchange.publish(message)
    connection.close
  end
end
