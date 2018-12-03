# frozen_string_literal: true

require 'rails_helper'
require 'ko_test_data'

# rubocop:disable Metrics/BlockLength
RSpec.describe PrepareBrainzArtist do
  def discogs_code
    123
  end

  def brainz_code
    'f9ea7be4-ebee-11e8-b919-d7e490fb38cb'
  end

  def code_for
    {
      brainz_code:  brainz_code,
      discogs_code: discogs_code
    }
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

    let(:blueprint) do
      TestData::Brainz.blueprint(
        :artist,
        'bdacc37b-8633-4bf8-9dd5-4662ee651aec'
      )
    end

    it 'returns the artist' do
      proxy = double
      expect(described_class.call(blueprint: blueprint, proxy: proxy))
        .to be_instance_of(Artist)
    end
  end

  context 'when the artist does not exists in the database' do
    let(:blueprint) do
      xml_string = KoTestData::GetBrainzXmlFor.path(
        'release/7452f8c9-f9bc-3ca7-859e-3220e57e4e4a' \
          '?inc=artists+labels+recordings+release-groups.xml'
      )
      BrainzBlueprint.from_xml(xml_string)
                     .artist_credit.name_credit.artist
    end

    let(:full_blueprint) do
      KoTestData::GetBrainzBlueprintFor.path(
        'artist/1d93c839-22e7-4f76-ad84-d27039efc048?inc=url-rels.xml'
      )
    end

    it 'returns the artist' do
      proxy = instance_double('Fake proxy')
      allow(proxy).to receive(:get).and_return(full_blueprint)
      expect(described_class.call(blueprint: blueprint, proxy: proxy))
        .to be_nil
    end
  end
end
# rubocop:enable Metrics/BlockLength
