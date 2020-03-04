# frozen_string_literal: true

require 'fake_proxy'
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

    let(:proxy) { FakeProxy.new }

    let(:args) do
      import_order = instance_double(
        'ImportRequest',
        code: 'bdacc37b-8633-4bf8-9dd5-4662ee651aec'
      )

      {
        blueprint:    blueprint,
        import_order: import_order,
        proxy:        proxy
      }
    end

    it 'returns the artist' do
      expect(described_class.call(args)).to be_instance_of(Artist)
    end

    it 'has not called get on the proxy' do
      described_class.call(args)
      expect(proxy).not_to have_received_get
    end
  end

  context 'when the artist does not exists in the database' do
    let(:blueprint) do
      TestData.by_name(:brainz_artist_slayer).blueprint
    end

    let(:import_order) do
      instance_double(
        'ImportRequest',
        code: 'bdacc37b-8633-4bf8-9dd5-4662ee651aec'
      )
    end

    let(:proxy) { FakeProxy.new }

    it 'returns the artist' do
      described_class.call(
        blueprint:    blueprint,
        import_order: import_order,
        proxy:        proxy
      )
      expect(proxy.matches(%r{/artist/})).to eq(1)
    end
  end
end
