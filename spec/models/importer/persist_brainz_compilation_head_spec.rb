require 'rails_helper'
require 'ko_test_data'
require 'importer/persist_brainz_artist_credit'

RSpec.describe Importer::PersistBrainzCompilationHead do
  before(:each) do
    having = {}

    code = '7d31891f-b9da-36de-ab08-98b1fdbbb023'
    @reference = BrainzReleaseGroupReference.from_code(code)
    having[@reference] = KoTestData.brainz_xml_for(@reference)

    artist_codes = [
      '2280ca0e-6968-4349-8c36-cb0cbd6ee95f',
      '37e9d7b2-7779-41b2-b2eb-3685351caad3'
    ]

    artist_codes.each do |artist_code|
      reference = BrainzArtistReference.from_code(artist_code)
      having[reference] = KoTestData.brainz_xml_for(reference)
    end

    @store = Importer::Store.new(having: having)
  end

  describe 'persisting a brainz release-group' do
    let(:compilation_head) do
      Importer::PersistBrainzCompilationHead.perform(
        data_import: FactoryBot.create(:data_import),
        store:   @store,
        reference:   @reference
      )
    end

    it 'is persisted' do
      expect(compilation_head.new_record?).to be false
    end

    it 'has the data_import set' do
      expect(compilation_head.data_import).to be_instance_of(DataImport)
    end
  end
end
