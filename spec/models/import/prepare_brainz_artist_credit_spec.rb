require 'rails_helper'
require 'ko_test_data'

RSpec.describe Import::PrepareBrainzArtistCredit do
  before(:each) do
    #@cache = Import::Cache.new

    reference = '693748be-7c18-39c3-af2e-2e62092090cf'
    xml = KoTestData.brainz_release(BrainzReleaseRef.new(code: reference))
    @artist_credit = MashedBrainz.from_xml(xml).artist_credit
  end

  specify '.perform' do
    ac_preparer = Import::PrepareBrainzArtistCredit.new(
      template: @artist_credit
    )
    ac_preparer.perform
    expect(ac_preparer.knowledge.missing?).to be true
  end
end
