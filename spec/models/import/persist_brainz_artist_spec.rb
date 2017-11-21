require 'rails_helper'
require 'ko_test_data'

RSpec.describe Import::PersistBrainzArtist do
  before(:each) do
    code       = '2280ca0e-6968-4349-8c36-cb0cbd6ee95f'
    @reference = BrainzArtistRef.new(code: code)
  end
  it 'persists an artist' do
    xml = KoTestData.brainz_xml_for(@reference)

    knowledge = Import::Knowledge.new(
      known: {
        brainz: {
          @reference.to_key => xml
        }
      }
    )

    artist = Import::PersistBrainzArtist.perform(
      knowledge: knowledge,
      reference: @reference
    )
    expect(artist.new_record?).to be false
    expect(artist.name).to eq('Jello Biafra')
  end

  it 'raises when .perform is called without having data cached' do
    expect do
      Import::PersistBrainzArtist.perform(
        knowledge: Import::Knowledge.new,
        reference: @reference
      )
    end.to raise_error(Import::KnowledgeMissing)
  end
end
