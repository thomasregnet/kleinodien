# frozen_string_literal: true

require 'mock_import_order'
require 'rails_helper'

RSpec.describe PersistPrepareBase do
  describe '.call' do
    it 'responds to .call' do
      expect(described_class).to respond_to(:call)
    end
  end

  describe '#proxy' do
    let(:pp_base) do
      described_class.new(
        import_order: MockImportOrder.new,
        proxy:        :fake_proxy
      )
    end

    it 'returns the proxy' do
      expect(pp_base.proxy).to eq(:fake_proxy)
    end
  end

  describe '#proxy' do
    let(:import_order) { MockImportOrder.new }
    let(:pp_base) do
      described_class.new(
        import_order: import_order,
        proxy:        double
      )
    end

    it 'returns the import_order' do
      expect(pp_base.import_order).to eq(import_order)
    end
  end

  describe '#call' do
    context 'when not defined otherwise' do
      let(:pp_base) do
        described_class.new(
          import_order: MockImportOrder.new,
          proxy:        double
        )
      end

      it 'raises an error' do
        expect { pp_base.call }
          .to raise_error(NoMethodError, /undefined method/)
      end
    end
  end
end
