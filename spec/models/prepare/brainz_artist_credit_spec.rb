require 'rails_helper'
require 'ko_test_data'

RSpec.describe Prepare::BrainzArtistCredit do
  before(:each) do
    brainz_id = '693748be-7c18-39c3-af2e-2e62092090cf'
    xml = KoTestData.brainz_release(BrainzReleaseId.new(value: brainz_id))
    @artist_credit = MashedBrainz::Release.xml(xml).artist_credit
  end

  specify '.perform' do
    ac_importer = Prepare::BrainzArtistCredit.new(
      @artist_credit, Import::Cache.new
    )
    ac_importer.using_data
    expect(ac_importer.cache.any_required?).to be true
  end
end
