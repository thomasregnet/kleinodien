# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportSubscriber do
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
