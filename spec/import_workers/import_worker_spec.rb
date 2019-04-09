# frozen_string_literal

require 'rails_helper'

# Just for testing
class FakeImportOrder < ImportOrder
  def next_pending; end
end

RSpec.describe ImportWorker do
  describe '#run' do
    context 'when no ImportOrder is pending' do
      it 'foos' do
        queue = class_double('ImportQueue').as_stubbed_const
        # https://stackoverflow.com/questions/38445625/rspec-class-spy-on-rails-mailer
        import_order = class_spy(FakeImportOrder)
        stub_const('FakeImportOrder', import_order)
        expect(queue).to receive(:subscribe)

        worker = described_class.new(import_order_class: FakeImportOrder)
        worker.run

        expect(import_order).to have_received(:next_pending)
      end
    end
  end
end
