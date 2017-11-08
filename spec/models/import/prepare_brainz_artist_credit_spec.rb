require 'rails_helper'
require 'ko_test_data'

RSpec.describe Import::PrepareBrainzArtistCredit do
  before(:each) do
    @cache = Import::Cache.new

    brainz_id = '693748be-7c18-39c3-af2e-2e62092090cf'
    xml = KoTestData.brainz_release(BrainzReleaseRef.new(code: brainz_id))
    @artist_credit = MashedBrainz::Release.xml(xml).artist_credit
  end

  specify '.perform' do
    ac_importer = Import::PrepareBrainzArtistCredit.new(
      template: @artist_credit
    )
    ac_importer.perform
    expect(ac_importer.cache.any_required?).to be true
  end
end
