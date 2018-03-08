require 'rails_helper'
require 'ko_test_data'

RSpec.describe Importer::PersistBrainzArtistCredit do
  # TODO: Specs for #find_by
  # TODO: Specs for #create
  describe 'persist an artist_credit' do
    before(:context) do
      DatabaseCleaner.start

      reference = BrainzReleaseReference.from_code(
        '693748be-7c18-39c3-af2e-2e62092090cf'
      )
      xml = KoTestData.brainz_xml_for(reference)
      release = MashedBrainz.from_xml(xml)
      @brainz_artist_credit = release.artist_credit

      having = {}
      %w[2280ca0e-6968-4349-8c36-cb0cbd6ee95f
         37e9d7b2-7779-41b2-b2eb-3685351caad3].each do |code|
        reference = BrainzArtistReference.from_code(code)
        xml = KoTestData.brainz_xml_for(reference)
        having[reference] = xml
      end

      store = Importer::Store.new(having: having)

      @artist_credit = Importer::PersistBrainzArtistCredit.perform(
        data_import: FactoryBot.create(:data_import),
        store:   store,
        blueprint:    @brainz_artist_credit
      )
    end

    it 'is persisted' do
      expect(@artist_credit.new_record?).to be false
    end

    it 'has the righet name' do
      expect(@artist_credit.name).to eq('Jello Biafra With NoMeansNo')
    end

    it 'has the DataImport set' do
      expect(@artist_credit.data_import).to be_instance_of(DataImport)
    end

    after(:context) do
      DatabaseCleaner.clean
    end
  end
end
