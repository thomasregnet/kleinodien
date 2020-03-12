# frozen_string_literal: true

require 'fake_proxy'
require 'mock_import_order'
require 'persist_mock'
require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe PersistImportService do
  it_behaves_like 'a service'

  describe '.call' do
    let(:import_order) { MockImportOrder.new }
    let(:proxy) { FakeProxy.new }

    let(:persister) do
      described_class.new(
        blueprint:    :fake_blueprint,
        import_order: import_order,
        proxy:        proxy
      )
    end

    context 'when success' do
      let(:mock_persister) do
        class_double('PersistMock')
          .as_stubbed_const(transfer_nested_constants: true)
      end

      before do
        allow(mock_persister).to receive(:call).and_return(:success)
      end

      it 'returns the persisted entity' do
        expect(persister.call).to eq(:success)
      end

      it 'locks the proxy' do
        persister.call
        expect(proxy).to be_locked
      end

      it 'sets the ImportOrder state to done' do
        persister.call
        expect(import_order).to be_done
      end
    end

    context 'when .call to the persisting class fails' do
      before do
        mock_persister = class_double('PersistMock')
                         .as_stubbed_const(transfer_nested_constants: true)

        allow(mock_persister).to receive(:call).and_raise('such a shame')
      end

      it 'returns nil' do
        expect(persister.call).to be_nil
      end

      it 'locks the proxy' do
        persister.call
        expect(proxy).to be_locked
      end

      it 'sets the ImportOrder state to "failed"' do
        persister.call
        expect(import_order).to be_failed
      end
    end
  end

  describe '#persister_class' do
    it 'returns the persister-class' do
      service = described_class.new(
        blueprint:    :fake_blueprint,
        import_order: MockImportOrder.new,
        proxy:        :fake_proxy
      )

      expect(service.send(:persister_class)).to eq(PersistMock)
    end
  end
end
