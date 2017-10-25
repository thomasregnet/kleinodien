require 'rails_helper'
require 'ko_test_data'

RSpec.describe Persist::BrainzArtistCredit do
  before(:each) do
    @cache = Import::Cache.new
    foreign_id = BrainzReleaseId.new(
      value: '693748be-7c18-39c3-af2e-2e62092090cf'
    )
    xml = KoTestData.brainz_xml_for(foreign_id)
    release = MashedBrainz::Release.xml(xml)
    @brainz_artist_credit = release.artist_credit
  end

  it 'persists an artist_credit' do
    artist_credit = Persist::BrainzArtistCredit.using_data(
      @brainz_artist_credit, @cache
    )
  end
end
