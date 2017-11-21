require 'rails_helper'
require 'ko_test_data'

RSpec.describe Import::PersistBrainzCompilationHead do
  before(:each) do
    brainz = {}

    code = '7d31891f-b9da-36de-ab08-98b1fdbbb023'
    @reference = BrainzReleaseGroupRef.new(code: code)
    brainz[@reference.to_key] = KoTestData.brainz_xml_for(@reference)

    artist_codes = [
      '2280ca0e-6968-4349-8c36-cb0cbd6ee95f',
      '37e9d7b2-7779-41b2-b2eb-3685351caad3'
    ]

    artist_codes.each do |artist_code|
      reference = BrainzArtistRef.new(code: artist_code)
      brainz[reference.to_key] = KoTestData.brainz_xml_for(reference)
    end

    @knowledge = Import::Knowledge.new(known: { brainz: brainz })
  end

  it 'persists a brainz release-group' do
    compilation_head = Import::PersistBrainzCompilationHead.perform(
      reference: @reference,
      knowledge: @knowledge
    )
    expect(compilation_head.new_record?).to be false
  end
end
