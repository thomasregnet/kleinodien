# frozen_string_literal: true

require 'fake_proxy'
require 'mock_import_order'
require 'rails_helper'
require 'test_data/brainz_service'
require 'test_data'

RSpec.describe PrepareBrainzArtist do
  let(:stub) do
    TestData.by_name(:brainz_artist_slayer).blueprint
  end

  context 'when the artist already exists in the database' do
    before do
      DatabaseCleaner.start
      FactoryBot.create(
        :artist,
        brainz_code: 'bdacc37b-8633-4bf8-9dd5-4662ee651aec'
      )
    end

    after { DatabaseCleaner.clean }

    let(:proxy) { FakeProxy.new }

    it 'has not called get on the proxy' do
      described_class.call(
        import_order: MockImportOrder.new,
        proxy:        proxy,
        stub:         stub
      )
      expect(proxy).not_to be_called_get
    end
  end

  context 'when the artist does not exists in the database' do
    let(:proxy) { FakeProxy.new }

    it 'returns the artist' do
      described_class.call(
        import_order: MockImportOrder.new,
        proxy:        proxy,
        stub:         stub
      )
      expect(proxy.matches(%r{/artist/})).to eq(1)
    end
  end
end
