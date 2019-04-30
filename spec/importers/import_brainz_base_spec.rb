# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportBrainzBase do
  describe 'import_request' do
    let(:importer) { described_class.new({}) }

    # rubocop:disable RSpec/MessageSpies
    it 'returns an ImportRequest' do
      transformer = class_double('TransformBrainzOrderToRequestService')
                    .as_stubbed_const(transfer_nested_constants: true)

      expect(transformer).to receive(:call).with(import_order: nil)
      importer.import_request
    end
  end
  # rubocop:enable RSpec/MessageSpies

  describe '#proxy' do
    let(:importer) { described_class.new({}) }

    it 'returns a BrainzProxy' do
      expect(importer.proxy).to be_instance_of(BrainzProxy)
    end
  end
end
