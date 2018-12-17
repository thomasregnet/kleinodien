# frozen_string_literal: true

require 'rails_helper'
require 'test_data/brainz_service'
require 'test_data'

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
      TestData.by_name(:brainz_artist_slayer).blueprint
    end

    it 'returns the artist' do
      proxy = double
      expect(described_class.call(blueprint: blueprint, proxy: proxy))
        .to be_instance_of(Artist)
    end
  end

  context 'when the artist does not exists in the database' do
    let(:blueprint) do
      TestData.by_name(:brainz_release_arise_jp_cd).blueprint
    end

    let(:full_blueprint) do
      TestData.by_name(:brainz_artist_sepultura).blueprint
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
