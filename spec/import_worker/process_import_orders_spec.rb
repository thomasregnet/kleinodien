# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

# rubocop:disable Metrics/BlockLength
RSpec.describe ProcessImportOrders do
  it_behaves_like 'a service'

  describe '.call' do
    context 'when there is a pending ImportOrder' do
      let(:import_order) { double }

      it 'calls ChooseImporter.call' do
        queue = class_double('ImportQueue')
                .as_stubbed_const(transfer_nested_constants: true)

        allow(queue).to receive(:next_pending_for)
          .and_return(import_order)

        chooser = class_double('ChooseImporter')
                  .as_stubbed_const(transfer_nested_constants: true)

        allow(chooser).to receive(:call)

        described_class.call(import_queue_name: 'test')

        expect(chooser).to have_received(:call).with(import_order: import_order)
      end
    end

    context 'when there is no pending ImportOrder' do
      it 'does not call ChooseImporter.call' do
        queue = class_double('ImportQueue')
                .as_stubbed_const(transfer_nested_constants: true)

        allow(queue).to receive(:next_pending_for).and_return(nil)

        chooser = class_double('ChooseImporter')
                  .as_stubbed_const(transfer_nested_constants: true)

        allow(chooser).to receive(:call)

        described_class.call(import_queue_name: 'test')

        expect(chooser).not_to have_received(:call)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
