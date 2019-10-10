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

  describe '#importer_class_for' do
    let(:worker) do
      described_class.new(import_queue_name: 'test', subscriber: 'test')
    end

    context 'with a valid import_order_type' do
      before { stub_const('ImportSomethingElse', nil) }

      it 'returns the expected importer-class' do
        expect(worker.send(:importer_class_for, 'SomethingElseImportOrder'))
          .to eq(ImportSomethingElse)
      end
    end

    context 'with a invalid import_order_type' do
      it 'raises an error' do
        expect { worker.send(:importer_class_for, 'BadEvil') }
          .to raise_error(NameError, /uninitialized constant BadEvil/)
      end
    end
  end

  describe '#process_orders' do
    context 'when there are pending import_orders' do
      let(:worker) do
        described_class.new(import_queue_name: 'test', subscriber: 'test')
      end
      let(:import_order) { double }
      let(:subscriber) { instance_double('ImportSubscriber') }

      before do
        stub_const('ImportSomethingElse', double)
        allow(ImportSomethingElse).to receive(:call)
        allow(import_order).to receive(:type).and_return('ImportSomethingElse')
        allow(ImportQueue).to receive(:next_pending_for)
          .and_return(import_order)
        allow(worker).to receive(:importer_class_for)
          .and_return(ImportSomethingElse)
      end

      it 'loops' do
        # expect(worker.process_orders).to be nil
      end
    end

    context 'when there are no pending import_orders' do
      let(:worker) do
        described_class.new(import_queue_name: 'test', subscriber: 'test')
      end

      it 'loops' do
        expect(worker.process_orders).to be nil
      end
    end
  end

  describe '#call_importer' do
    let(:worker) do
      described_class.new(import_queue_name: 'test', subscriber: 'test')
    end
    let(:import_order) { double }
    let(:importer_class) { stub_const('ImportSomethingElse', spy) }

    before do
      # allow(worker).to receive(:process_orders_import_class_and_order)
      #   .and_return([importer_class, import_order])
      allow(import_order).to receive(:type)
      allow(worker).to receive(:next_pending_order).and_return(import_order)
      allow(worker).to receive(:importer_class_for).and_return(importer_class)
    end

    it 'calls .call at the importer-class' do
      worker.send(:call_importer)
      expect(importer_class).to have_received(:call)
    end
  end

  describe '#process_orders_import_class_and_order' do
    context 'with pending orders' do
      let(:worker) do
        described_class.new(import_queue_name: 'test', subscriber: 'test')
      end
      let(:import_order) { double }

      before do
        allow(ImportQueue).to receive(:next_pending_for)
          .and_return(import_order)
        allow(import_order).to receive(:type)
        allow(worker).to receive(:importer_class_for).and_return(:fake_class)
      end

      it 'returns the expected parameters' do
        expect(worker.send(:process_orders_import_class_and_order))
          .to eq([:fake_class, import_order])
      end
    end

    context 'without pending orders' do
      let(:worker) do
        described_class.new(import_queue_name: 'test', subscriber: 'test')
      end

      before do
        allow(ImportQueue).to receive(:next_pending_for)
          .and_return(nil)
      end

      it 'returns nil' do
        expect(worker.send(:process_orders_import_class_and_order)).to be_nil
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
