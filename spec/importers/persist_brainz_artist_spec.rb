# frozen_string_literal: true

require 'fake_proxy'
require 'test_data'
require 'rails_helper'

RSpec.describe PersistBrainzArtist do
  let(:blueprint) do
    TestData.by_name(:brainz_artist_slayer).blueprint
  end

  let(:import_request) do
    BrainzArtistImportRequest.new(
      code: 'bdacc37b-8633-4bf8-9dd5-4662ee651aec'
    )
  end

  context 'when the Artist does not exist' do
    describe '.call' do
      it 'persists the Artist' do
        proxy = FakeProxy.new

        artist = described_class.call(
          import_order:   FactoryBot.create(:brainz_import_order),
          import_request: import_request,
          proxy:          proxy
        )
        expect(artist).not_to be_new_record
      end
    end
  end

  context 'when the Artist exists' do
    describe '.call' do
      before do
        FactoryBot.create(
          :artist,
          brainz_code: 'bdacc37b-8633-4bf8-9dd5-4662ee651aec',
          name:        'No more slaying'
        )
      end

      it 'returns that artist' do
        args = {
          import_order:   FactoryBot.create(:brainz_import_order),
          import_request: import_request,
          proxy:          FakeProxy.new
        }

        expect(described_class.call(args).name)
          .to eq('No more slaying')
      end
    end
  end
end
