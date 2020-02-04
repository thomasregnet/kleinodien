# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe ImportWorker do
  describe '#run' do
    let(:subscriber) { instance_double('ImportSubscriber') }
    let(:worker) do
      described_class.new(
        import_queue_name: 'my_queue',
        subscriber:        subscriber
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
    context 'with valid parameters' do
      let(:subscriber) { instance_double('ImportSubscriber') }
      let(:args) do
        {
          import_queue_name: 'my_queue',
          subscriber:        subscriber
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

    context 'with a blank import_queue_name' do
      let(:subscriber) { instance_double('ImportSubscriber') }
      let(:args) do
        {
          import_queue_name: '',
          subscriber:        subscriber
        }
      end

      # the regex ("can.t be blank")uses an dot instead of an
      # apostrophe because the apostrophe confuses emacs
      it 'raises an ArgumentError' do
        expect { described_class.run(args) }
          .to raise_error(ArgumentError, /can.t be blank/)
      end
    end
  end

  describe '#call_importer' do
    let(:import_order) { double }
    let(:worker) do
      described_class.new(import_queue_name: 'test', subscriber: 'test')
    end

    it 'calls ChooseImporter.call' do
      chooser = class_double('ChooseImporter')
                .as_stubbed_const(transfer_nested_constants: true)

      allow(worker).to receive(:next_pending_order).and_return(import_order)
      allow(chooser).to receive(:call)

      worker.send(:call_importer)

      expect(chooser).to have_received(:call)
    end
  end

  describe '#next_pending_order' do
    let(:worker) do
      described_class.new(import_queue_name: 'test', subscriber: 'test')
    end

    it 'gets the next pending ImportOrder form the ImportQueue' do
      queue = class_double('ImportQueue')
              .as_stubbed_const(transfer_nested_constants: true)

      allow(queue).to receive(:next_pending_for)

      worker.send(:next_pending_order)

      expect(queue).to have_received(:next_pending_for)
    end
  end

  describe '#process_orders' do
    let(:worker) do
      described_class.new(import_queue_name: 'test', subscriber: 'test')
    end

    it 'calls #call_importer' do
      allow(worker).to receive(:call_importer).and_return(nil)

      worker.send(:process_orders)

      expect(worker).to have_received(:call_importer)
    end
  end
end
# rubocop:enable Metrics/BlockLength
