# frozen_string_literal: true

require 'fake_proxy'
require 'mock_import_order'
require 'rails_helper'
require 'test_data'
require 'test_data/brainz_service'

RSpec.describe PrepareBrainzRecording do
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
      allow(PrepareBrainzArtistCredit).to receive(:call)

      args = {
        import_order:   MockImportOrder.new,
        import_request: import_request,
        proxy:          FakeProxy.new
      }

      expect(described_class.call(args)).to be_nil
    end
  end

  context 'with "The Duellists"' do
    let(:blueprint) do
      TestData.by_name(:brainz_recording_the_duellists).blueprint
    end

    let(:import_request) do
      BrainzRecordingImportRequest.new(
        code: '5935ec91-8124-42ff-937f-f31a20ffe58f'
      )
    end

    let(:proxy) { FakeProxy.new }

    it 'prepares the artist' do
      proxy = FakeProxy.new
      allow(PrepareBrainzArtistCredit).to receive(:call)

      described_class.call(
        import_order:   MockImportOrder.new,
        import_request: import_request,
        proxy:          proxy
      )

      expect(proxy.matches(%r{/recording/})).to eq(1)
    end
  end
end
