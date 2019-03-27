# frozen_string_literal: true

require 'rails_helper'

# Just for test
class FakeImportQueueConnection
  attr_reader :close, :start
end

# Just for testing
# this class smells of :reek:InstanceVariableAssumption
class FakeImportQueueExchange
  def publish(message)
    @message = message
  end

  def published_message
    @message
  end
end

# Just for testing
class FakeImportQueuePublishBase < ImportQueuePublishBase
  name :fake

  def initialize(args)
    super(args)

    @connection = FakeImportQueueConnection.new
    @exchange   = FakeImportQueueExchange.new
  end

  attr_reader :connection, :exchange
end

# Just for testing
class FakeImportQueuePublishBaseCall < ImportQueuePublishBase
  def call
    "called with \"#{message}\""
  end
end

class FakeImportQueuePublishBaseClassMethod < ImportQueuePublishBase
  name :fake
end

# rubocop:disable Metrics/BlockLength
RSpec.describe ImportQueuePublishBase do
  describe '#call' do
    let(:publisher) { FakeImportQueuePublishBase.new(message: 'my message') }

    it 'publishes the message' do
      publisher.call
      expect(publisher.exchange.published_message).to eq('my message')
    end
  end

  context 'when calling class methods' do
    before do
      # TODO: get Bunny host name from configuration
      connection = Bunny.new(host: 'rabbit')
      connection.start

      channel = connection.create_channel
      exchange = channel.fanout(:fake.to_s)
      queue = channel.queue('', exclusive: true)

      queue.bind(exchange)

      @thread = Thread.new do
        queue.subscribe(block: false) do |_delivery_info, _properties, body|
          @message = body
        end
      end
    end

    # rubocop:disable RSpec/InstanceVariable
    after do
      @message = nil
      @thread.join
    end

    describe '.call' do
      it 'publishes the message' do
        FakeImportQueuePublishBaseClassMethod.call(message: 'my message')
        expect(@message).to eq('my message')
      end
    end

    describe '.run' do
      it 'publishes "run"' do
        FakeImportQueuePublishBaseClassMethod.run
        expect(@message).to eq('run')
      end
    end
  end
end
# rubocop:disable RSpec/InstanceVariable
# rubocop:enable Metrics/BlockLength
