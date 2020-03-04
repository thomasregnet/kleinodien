# frozen_string_literal: true

require 'fake_proxy'
require 'mock_import_order'
require 'rails_helper'
require 'shared_examples_for_services'
require 'test_data'

RSpec.describe PersistBrainzPiece do
  it_behaves_like 'a service'

  def brainz_code
    '5935ec91-8124-42ff-937f-f31a20ffe58f'
  end

  describe '.call' do
    context 'when the Piece already exists' do
      before do
        FactoryBot.create(
          :piece,
          brainz_code: brainz_code,
          title:       'Test Dummy'
        )
      end

      let(:blueprint) do
        TestData.by_name(:brainz_recording_highway_to_hell).blueprint
      end

      it 'returns the Piece' do
        args = {
          code:         brainz_code,
          import_order: MockImportOrder.new,
          proxy:        FakeProxy.new
        }

        expect(described_class.call(args).title).to eq('Test Dummy')
      end
    end

    context 'when the Piece does not exist' do
      let(:blueprint) do
        TestData.by_name(:brainz_recording_highway_to_hell).blueprint
      end

      it 'returns the Piece' do
        args = {
          code:         brainz_code,
          import_order: FactoryBot.create(:brainz_import_order),
          proxy:        FakeProxy.new
        }

        expect(described_class.call(args).title).to eq('Highway to Hell')
      end
    end
  end
end
