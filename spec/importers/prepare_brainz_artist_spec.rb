# frozen_string_literal: true

require 'rails_helper'
require 'ko_test_data'

RSpec.describe PrepareBrainzArtist do
  def discogs_code
    123
  end

  context 'without a complete dataset' do
    let(:blueprint) do
      release_blueprint = KoTestData::GetBrainzBlueprintFor.path(
        'release/7452f8c9-f9bc-3ca7-859e-3220e57e4e4a?' \
          'inc=artists+labels+recordings+release-groups.xml'
      )
      release_blueprint.artist_credit.name_credit.first
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

  context 'with a complete dataset' do
    let(:blueprint) do
      KoTestData::GetBrainzBlueprintFor.path(
        'artist/2280ca0e-6968-4349-8c36-cb0cbd6ee95f?inc=url-rels.xml'
      )
    end

    it 'does not call the proxy' do
      proxy = spy
      described_class.call(
        blueprint: blueprint,
        proxy:     proxy
      )

      expect(proxy).not_to have_received(:get)
    end
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

    it 'returns the artist' do
      proxy = double
      allow(proxy).to receive(:get).and_return(:foo)
      expect(described_class.call(blueprint: blueprint, proxy: proxy))
        .not_to be_nil
    end
  end

  # context 'when the artist does not exist in the database' do
  #   let(:blueprint) do
  #     KoTestData::GetBrainzBlueprintFor.path(
  #       'artist/1d93c839-22e7-4f76-ad84-d27039efc048?inc=url-rels.xml'
  #     )
  #   end

  #   it 'calls the proxy' do
  #     proxy = spy
  #     described_class.call(
  #       blueprint: blueprint,
  #       proxy:     proxy
  #     )
  #     expect(proxy).to have_received(:get)
  #   end
  # end
end
