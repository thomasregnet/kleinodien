# frozen_string_literal: true

require 'fake_proxy'
require 'test_data'
require 'rails_helper'
require 'shared_examples_for_persister_and_preparer_base_classes'

RSpec.describe PersistBrainzArtist do
  let(:code) { 'bdacc37b-8633-4bf8-9dd5-4662ee651aec' } # Slayer

  context 'when the Artist does not exist' do
    describe '.call' do
      it 'persists the Artist' do
        proxy = FakeProxy.new

        artist = described_class.call(
          code:         code,
          import_order: FactoryBot.create(:brainz_import_order),
          proxy:        proxy
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
          code:         code,
          import_order: FactoryBot.create(:brainz_import_order),
          proxy:        FakeProxy.new
        }

        expect(described_class.call(args).name)
          .to eq('No more slaying')
      end
    end
  end
end
