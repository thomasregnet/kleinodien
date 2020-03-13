# frozen_string_literal: true

require 'fake_proxy'
require 'mock_import_order'
require 'prepare_mock'
require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe PrepareImportService do
  it_behaves_like 'a service'

  describe '.call' do
    let(:import_order) { MockImportOrder.new }
    let(:proxy) { FakeProxy.new }

    let(:preparer) do
      described_class.new(
        import_order: import_order,
        proxy:        proxy,
        stub:         :fake_stub
      )
    end

    context 'when it passes' do
      it 'returns a true value' do
        expect(preparer.call).to be_truthy
      end
    end

    context 'when it fails' do
      let(:mock_preparer) do
        class_double('PrepareMock')
          .as_stubbed_const(transfer_nested_constants: true)
      end

      before do
        allow(mock_preparer).to receive(:call).and_raise('Bad evil')
      end

      it 'has called the preparer' do
        preparer.call
        expect(mock_preparer).to have_received(:call)
      end

      it 'returns a false value' do
        expect(preparer.call).to be_falsy
      end
    end
  end
end
