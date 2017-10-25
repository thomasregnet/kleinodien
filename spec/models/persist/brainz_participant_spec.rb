require 'rails_helper'
require 'ko_test_data'

RSpec.describe Persist::BrainzParticipant do
  before(:each) do
    @cache = Import::Cache.new

    brainz_id  = '693748be-7c18-39c3-af2e-2e62092090cf'
    foreign_id = BrainzReleaseId.new(value: brainz_id)
    xml        = KoTestData.brainz_xml_for(foreign_id)
    release    = MashedBrainz::Release.xml(xml)
    @original  = release.artist_credit.name_credits[0] # Jello Biafra
  end

  it 'persists the participant' do
    foreign_id = BrainzArtistId.new(
     value: '2280ca0e-6968-4349-8c36-cb0cbd6ee95f'
    )
    xml = KoTestData.brainz_xml_for(foreign_id)
    @cache.store_brainz(foreign_id, xml)
    Persist::BrainzParticipant.using_data(@original, @cache)
  end
end
