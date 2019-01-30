# frozen_string_literal: true

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
        TestData.by_name(:brainz_recording_highway_to_hell)
      end

      let(:import_request) do
        BrainzRecordingImport_request.new(code: brainz_code)
      end

      it 'returns the Piece' do
        proxy = spy
        allow(proxy).to receive(:get).and_return(blueprint)
        args = { import_request: import_request, proxy: proxy }
        expect(described_class.call(args).title).to eq('Test Dummy')
      end
    end
  end
end
