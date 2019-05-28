# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportWorker do
  describe '#run' do
    let(:subscriber) { instance_double('ImportSubscriber') }
    let(:worker) { described_class.new(subscriber: subscriber) }

    it 'stops when it receives a "stop" message' do
      allow(worker).to receive(:process_orders)
      allow(subscriber).to receive(:perform).and_return('run', 'stop')
      expect(worker.run).to be_nil
    end
  end
end
