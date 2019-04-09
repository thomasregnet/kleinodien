# frozen_string_literal

require 'rails_helper'

# Just for testing
class FakeImportOrder < ImportOrder
  def next_pending; end
  def self.call(_args); end
end

RSpec.describe ImportWorker do
  describe '#run' do
    context 'when no ImportOrder is pending' do
      it 'foos' do
        import_order = class_double('FakeImportOrder').as_stubbed_const
        deliverer    = class_double('DeliverImportOrderService')
                       .as_stubbed_const

        expect(import_order).to receive(:next_pending).and_return(:foo)
        expect(deliverer).to receive(:call)

        worker = described_class.new(import_order_class: FakeImportOrder)
        worker.run
      end
    end
  end

  describe '#subscribe' do
  end

  describe '#unsubscribe' do
    context 'when subscribed' do
      let(:worker) do
        described_class.new(import_queue_name: 'some_queue')
      end

      it 'calls #unsubscribe on the ImportQueue' do
        import_queue = class_double('ImportQueue').as_stubbed_const

        expect(import_queue).to receive(:unsubscribe)

        allow(worker).to receive(:import_queue).and_return(import_queue)
        worker.unsubscribe
      end
    end

    context 'when not subscribed' do
      let(:worker) do
        described_class.new(import_queue_name: 'some_queue')
      end

      it 'calls #unsubscribe on the ImportQueue' do
        import_queue = class_double('ImportQueue').as_stubbed_const
        expect(import_queue).not_to receive(:unsubscribe)

        worker.unsubscribe
      end
    end

  end
end
