require 'rails_helper'
require 'fake_reference'
require 'ko_test_data'

RSpec.describe Import::PersistBrainzArtist do
  let(:reference) do
    BrainzArtistReference.from_code('2280ca0e-6968-4349-8c36-cb0cbd6ee95f')
  end

  describe 'persist an artist' do
    before(:context) do
      DatabaseCleaner.start

      reference = BrainzArtistReference.from_code(
        '2280ca0e-6968-4349-8c36-cb0cbd6ee95f'
      )

      store = Import::Store.new(
        having: {
          reference => KoTestData.brainz_xml_for(reference)
        }
      )

      @artist = described_class.perform(
        data_import: FactoryBot.create(:data_import),
        store: store,
        reference: reference
      )
    end

    it 'is persisted' do
      expect(@artist.new_record?).to be false
    end

    it 'has the right name set' do
      expect(@artist.name).to eq('Jello Biafra')
    end

    it 'has the data_import set' do
      expect(@artist.data_import).not_to be_nil
    end

    after(:context) do
      DatabaseCleaner.clean
    end
  end

  context 'with missing data' do
    let(:persister) do
      described_class.new(
        store: Import::Store.new,
        reference: FakeReference.new(code: 'foo')
      )
    end

    it 'raises Import::StoreMissing' do
      expect { persister.perform }.to raise_error(Import::KnowledgeMissing)
    end
  end
end
