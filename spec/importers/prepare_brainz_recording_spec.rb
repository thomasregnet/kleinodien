# frozen_string_literal: true

require 'rails_helper'
require 'test_data'
require 'test_data/brainz_service'

RSpec.describe PrepareBrainzRecording do
  context 'when the recording already exists in the database' do
    before do
      FactoryBot.create(
        :piece,
        brainz_code: '5935ec91-8124-42ff-937f-f31a20ffe58f'
      )
    end

    let(:import_request) do
      BrainzRecordingImportRequest.new(
        code: '5935ec91-8124-42ff-937f-f31a20ffe58f'
      )
    end

    let(:blueprint) do
      TestData.by_name(:brainz_recording_highway_to_hell).blueprint
    end

    it 'returns the artist' do
      proxy = double
      allow(proxy).to receive(:get).and_return(blueprint)

      expect(described_class.call(import_request: import_request, proxy: proxy))
        .to be_instance_of(Piece)
    end
  end

  context 'when the recording does not exist in the database' do
    let(:import_request) do
      BrainzRecordingImportRequest.new(
        code: '5935ec91-8124-42ff-937f-f31a20ffe58f'
      )
    end

    let(:blueprint) do
      TestData.by_name(:brainz_recording_highway_to_hell).blueprint
    end

    it 'prepares the artist' do
      proxy = double
      allow(proxy).to receive(:get).and_return(blueprint)

      allow(PrepareBrainzArtistCredit).to receive(:call)

      expect(described_class.call(import_request: import_request, proxy: proxy))
        .to be_nil
    end
  end
end
