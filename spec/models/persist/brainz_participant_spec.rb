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
    Persist::BrainzParticipant.using_data(@original, @cache)
  end
end
