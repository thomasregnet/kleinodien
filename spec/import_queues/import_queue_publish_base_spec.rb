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

RSpec.describe ImportQueuePublishBase do
  describe '#call' do
    let(:publisher) { FakeImportQueuePublishBase.new(message: 'my message') }

    it 'publishes the message' do
      publisher.call
      expect(publisher.exchange.published_message).to eq('my message')
    end
  end

  describe '.call' do
    it 'publishes the message' do
      expect(FakeImportQueuePublishBaseCall.call(message: 'my message'))
        .to eq('called with "my message"')
    end
  end

  describe '.run' do
    it 'publishes "run"' do
      expect(FakeImportQueuePublishBaseCall.run).to eq('called with "run"')
    end
  end
end
