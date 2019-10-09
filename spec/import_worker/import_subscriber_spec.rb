# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe ImportSubscriber do
  # OPTIMIZE: The tests of ImportSubscriber depend on the redis-connection.
  # OPTIMIZE: Maybe do better mocking of the redis-connection.
  describe '#perform' do
    let(:subscriber) { described_class.new(channel: 'test', timeout: 0.000001) }

    it 'returns true' do
      expect(subscriber.perform).to be_truthy
    end
  end

  describe '#handle_message' do
    let(:subscriber) { described_class.new(channel: 'test') }
    let(:expected_message) { 'test message' }
    let(:message_obj) { double }
    let(:redis) { double }

    it 'returns the message' do
      allow(message_obj).to receive(:message).and_yield(nil, expected_message)
      allow(redis).to receive(:unsubscribe)
      allow(subscriber).to receive(:redis).and_return(redis)

      expect(subscriber.send(:handle_message, message_obj))
        .to eq(expected_message)
    end
  end

  describe '#redis' do
    let(:subscriber) { described_class.new(channel: 'test') }

    it 'retuns an redis connection' do
      expect(subscriber.send(:redis)).to be_instance_of(Redis)
    end
  end

  describe '#unsubscribe' do
    let(:redis) { instance_double('Redis', unsubscribe: true) }
    let(:subscriber) do
      subscriber = described_class.new(channel: 'test')
      allow(subscriber).to receive(:redis).and_return(redis)

      subscriber
    end

    it 'calls redis#unsubscribe' do
      subscriber.send(:unsubscribe)

      expect(redis).to have_received(:unsubscribe)
    end
  end
end
# rubocop:enable Metrics/BlockLength
