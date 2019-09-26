# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportWorker do
  describe '#run' do
    let(:import_order_class) { instance_double('BrainzReleaseImportOrder') }
    let(:subscriber) { instance_double('ImportSubscriber') }
    let(:worker) do
      described_class.new(
        import_order_class: import_order_class,
        subscriber:         subscriber
      )
    end

    it 'stops when it receives a "stop" message' do
      allow(worker).to receive(:process_orders)
      allow(subscriber).to receive(:perform).and_return('run', 'stop')
      expect(worker.run).to be_nil
    end
  end

  # https://www.rubydoc.info/gems/rubocop-rspec/1.6.0/RuboCop/Cop/RSpec/AnyInstance
  describe '.run' do
    let(:import_order_class) { instance_double('BrainzReleaseImportOrder') }
    let(:subscriber) { instance_double('ImportSubscriber') }
    let(:args) do
      {
        import_order_class: import_order_class,
        subscriber:         subscriber
      }
    end
    let(:worker) { instance_double(described_class) }

    before do
      allow(described_class).to receive(:new).and_return(worker)
      allow(worker).to receive(:run).and_return('run called')
    end

    it 'calls #run' do
      expect(described_class.run(args)).to eq('run called')
    end
  end
end
