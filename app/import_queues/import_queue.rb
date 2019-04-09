# frozen_string_literal: true

# RabbitMQ pub/sub for imports
class ImportQueue
  def self.publish(args)
    new(args).publish
  end

  def self.subscribe(args)
    new(args).subscribe
  end

  def initialize(args)
    @name = args[:name]
  end

  attr_reader :queue_name

  def publish
  end

  def subscribe
  end

  def unsubscribe
  end
end
