# frozen_string_literal: true

require 'rails_helper'
require 'ko_test_data'

RSpec.describe PrepareBrainzArtist do
  def discogs_code
    123
  end

  context 'when the artist already exists in the database' do
    before do
      DatabaseCleaner.start
      FactoryBot.create(:artist, discogs_code: discogs_code)
    end

    after { DatabaseCleaner.clean }

    let(:blueprint) do
      KoTestData::GetBrainzBlueprintFor.path(
        'artist/1d93c839-22e7-4f76-ad84-d27039efc048?inc=url-rels.xml'
      )
    end

    it 'return the artist' do
      proxy = double
      allow(proxy).to receive(:get).and_return(:foo)
      expect(described_class.call(blueprint: blueprint, proxy: proxy))
        .not_to be_nil
    end
  end

  context 'when the artist does not exist in the database' do
    let(:blueprint) do
      KoTestData::GetBrainzBlueprintFor.path(
        'artist/1d93c839-22e7-4f76-ad84-d27039efc048?inc=url-rels.xml'
      )
    end

    it 'calls the proxy' do
      proxy = spy
      described_class.call(
        blueprint: blueprint,
        proxy:     proxy
      )
      expect(proxy).to have_received(:get)
    end
  end
end
