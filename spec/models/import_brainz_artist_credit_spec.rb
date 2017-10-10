require 'rails_helper'
require 'ko_test_data'

RSpec.describe ImportBrainzArtistCredit do
  before(:each) do
    xml = KoTestData.brainz_release(
      '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a'
    )
    @artist_credit = MashedBrainz::Release.xml(xml).artist_credit
  end

  specify '.perform' do
    ac_importer = ImportBrainzArtistCredit.new(@artist_credit, ImportCache.new)
    # TODO: The test of .perform does nothing at all
    # expect(ac_importer.cache.any_required?).to be true
  end
end
