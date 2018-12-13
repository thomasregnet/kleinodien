# frozen_string_literal: true

require 'test_data'
require 'rails_helper'

RSpec.describe PersistBrainzArtist do
  let(:blueprint) do
    TestData.by_name(:brainz_artist_slayer).blueprint
  end

  context 'when the Artist does not exist' do
    describe '.call' do
      let(:artist) do
        described_class.call(blueprint: blueprint)
      end

      it 'persists the Artist' do
        expect(artist).to be_instance_of(Artist)
      end

      it 'sets the name' do
        expect(artist.name).to eq('Slayer')
      end

      it 'sets the begin_date' do
        expect(artist.begin_date.year).to eq(1981)
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
        expect(described_class.call(blueprint: blueprint).name)
          .to eq('No more slaying')
      end
    end
  end
end
