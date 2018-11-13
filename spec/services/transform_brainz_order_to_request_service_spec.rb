# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

class TestWrongImportOrder
end

RSpec.describe TransformBrainzOrderToRequestService do
  it_behaves_like 'a service'

  # the specs for the service belongs here

  context 'raises with a wrong ImportOrder class' do
    let(:args) do
      {
        expected_kind: :artist,
        import_order:  TestWrongImportOrder
      }
    end

    it 'raises an ArgumentError' do
      expect { described_class.call(args) }.to raise_error ArgumentError
    end
  end

  context 'when the kind is "release"' do
    let(:args) do
      import_order = FactoryBot.build(:brainz_import_order, kind: 'release')
      {
        expected_kind: :release,
        import_order: import_order
      }
    end

    it 'returns a BrainzReleaseImportRequest object' do
      expect(described_class.call(args))
        .to be_instance_of BrainzReleaseImportRequest
    end
  end

  context 'when the expected_kind does not fit' do
    let(:args) do
      import_order = FactoryBot.build(:brainz_import_order, kind: 'release')
      {
        expected_kind: :artist,
        import_order:  import_order
      }
    end

    it 'raises an ArgumentError' do
      expect { described_class.call(args) }
        .to raise_error ArgumentError
    end
  end
end
