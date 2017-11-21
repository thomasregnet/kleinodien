require 'rails_helper'
require 'ko_test_data'

RSpec.describe Import::PrepareBrainzArtist do
  before(:context) do
    @reference = BrainzArtistRef.new(
      code: '2280ca0e-6968-4349-8c36-cb0cbd6ee95f'
    )
  end

  specify '.perform without knowledged artist' do
    knowledge = Import::Knowledge.new
    artist_importer = Import::PrepareBrainzArtist.new(
      knowledge: knowledge,
      reference: @reference
    )
    artist_importer.perform
    expect(knowledge.missing?).to be true
  end

  specify '.perform with known artist' do
    xml = KoTestData.brainz_xml_for(@reference)
    knowledge = Import::Knowledge.new(
      known: {
        brainz: {
          @reference.to_key => xml
        }
      }
    )

    Import::PrepareBrainzArtist.perform(
      knowledge: knowledge,
      reference: @reference
    )

    expect(knowledge.missing?).to be false
  end
end
