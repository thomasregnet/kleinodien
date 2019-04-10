# frozen_string_literal: true

require 'rails_helper'

# Just for testing
class FakeImportOrder < ImportOrder
  def next_pending; end

  def self.call(_args); end
end

# rubocop:disable RSpec/MessageSpies
RSpec.describe ImportWorker do
  describe '#perform' do
    context 'with a pending ImportOrder' do
      it 'calls the DeliverImportOrderService' do
        import_order = class_double('FakeImportOrder').as_stubbed_const
        deliverer    = class_double('DeliverImportOrderService')
                       .as_stubbed_const

        expect(import_order).to receive(:next_pending).and_return(:foo)
        expect(deliverer).to receive(:call)

        worker = described_class.new(import_order_class: FakeImportOrder)
        worker.perform
      end
    end
  end

  describe '#subscribe' do
    let(:worker) { described_class.new(import_queue_name: 'some_queue') }
    let(:import_queue) { class_double('ImportQueue').as_stubbed_const }

    context 'when not subscribed' do
      it 'subscribes' do
        expect(import_queue).to receive(:subscribe)

        worker.subscribe
      end
    end

    context 'when subscribed' do
      it 'does not subscribe' do
        allow(worker).to receive(:import_queue).and_return(import_queue)
        expect(import_queue).not_to receive(:subscribe)

        worker.subscribe
      end
    end
  end

  describe '#unsubscribe' do
    let(:worker) { described_class.new(import_queue_name: 'some_queue') }

    context 'when subscribed' do
      it 'calls #unsubscribe on the ImportQueue' do
        import_queue = class_double('ImportQueue').as_stubbed_const

        expect(import_queue).to receive(:unsubscribe)

        allow(worker).to receive(:import_queue).and_return(import_queue)
        worker.unsubscribe
      end
    end

    context 'when not subscribed' do
      it 'calls #unsubscribe on the ImportQueue' do
        import_queue = class_double('ImportQueue').as_stubbed_const
        expect(import_queue).not_to receive(:unsubscribe)

        worker.unsubscribe
      end
    end
  end
end
# rubocop:enable RSpec/MessageSpies
