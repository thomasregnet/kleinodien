# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

# Just for testing
class FakeImportOrder < ImportOrder
end

# Just for testing
class FakeImporter
  def self.call(_args); end
end

RSpec.describe DeliverImportOrderService do
  it_behaves_like 'a service'

  describe '#importer_class' do
    let(:deliverer) do
      described_class.new(import_order: FakeImportOrder.new)
    end

    it 'returns the right importer class as constant' do
      expect(deliverer.send(:importer_class)).to eq(FakeImporter)
    end
  end

  describe '#call' do
    let(:import_order) { FakeImportOrder.new }

    # rubocop:disable RSpec/MessageSpies
    it 'calls the importer' do
      importer = class_double('FakeImporter').as_stubbed_const

      expect(importer).to receive(:call).with(import_order: import_order)
      deliverer = described_class.new(import_order: import_order)
      deliverer.call
    end
    # rubocop:enable RSpec/MessageSpies
  end
end
