# frozen_string_literal: true

require 'rails_helper'
require 'test_data/brainz_service'
require 'test_data'

RSpec.describe PrepareBrainzArtist do
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

    let(:import_request) do
      BrainzArtistImportRequest.new(
        code: 'bdacc37b-8633-4bf8-9dd5-4662ee651aec'
      )
    end

    it 'returns the artist' do
      proxy = double
      allow(proxy).to receive(:get).and_return(blueprint)

      args = {
        import_order:   :fake_import_order,
        import_request: import_request,
        proxy:          proxy
      }
      expect(described_class.call(args)).to be_instance_of(Artist)
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
      args = {
        import_order:   :fake_import_order,
        import_request: :fake,
        proxy:          proxy
      }
      expect(described_class.call(args)).not_to be_nil
    end
  end
end
