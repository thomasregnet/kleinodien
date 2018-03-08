require 'rails_helper'
require 'ko_test_data'

RSpec.describe Importer::PrepareBrainzArtist do
  let(:reference) do
    BrainzArtistReference.from_code('2280ca0e-6968-4349-8c36-cb0cbd6ee95f')
  end

  context 'with an unknown artist' do
    describe '#store.missing?' do
      it 'returns true' do
        artist_importer = described_class.new(
          reference: reference
        )
        artist_importer.perform
        expect(artist_importer.store.missing?).to be true
      end
    end
  end

  context 'with a known artist' do
    describe '#store.missing?' do
      it 'returns false' do
        store = Importer::Store.new(
          having: { reference => KoTestData.brainz_xml_for(reference) }
        )

        artist_importer = described_class.new(
          reference: reference,
          store:     store
        )

        artist_importer.perform
        expect(artist_importer.store.missing?).to be false
      end
    end
  end
end
