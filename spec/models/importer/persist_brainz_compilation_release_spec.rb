require 'rails_helper'
require 'ko_test_data'

RSpec.describe Importer::PersistBrainzCompilationRelease do
  let(:reference) do
    BrainzReleaseReference.from_code('7452f8c9-f9bc-3ca7-859e-3220e57e4e4a')
  end

  it 'persists a MusicBrainz release' do
    having = {}
    having[reference] = KoTestData.brainz_xml_for(reference)

    artist_ref = BrainzArtistReference.from_code(
      '1d93c839-22e7-4f76-ad84-d27039efc048'
    )
    having[artist_ref] = KoTestData.brainz_xml_for(artist_ref)

    release_group_ref = BrainzReleaseGroupReference.from_code(
      '5fc9ba9d-bc39-38fc-a479-eadbf0f3a933'
    )
    having[release_group_ref] = KoTestData.brainz_xml_for(
      release_group_ref
    )

    compilation_release = described_class.perform(
      data_import: FactoryBot.create(:data_import),
      store:       Importer::Store.new(having: having),
      reference:   reference
    )
    expect(compilation_release.title).to eq('Arise')
    expect(compilation_release.new_record?).to be false
    expect(compilation_release.data_import).to be_instance_of(DataImport)
  end

  it 'raises when data is missing' do
    expect do
      described_class.perform(
        reference: reference
      )
    end.to raise_error(Importer::KnowledgeMissing)
  end
end
