require 'rails_helper'
require 'brainz_test_helper'
require 'discogs_test_helper'

RSpec.describe 'insert a release from Discogs and MusicBrainz' do
  before(:all) do DatabaseCleaner.start
    release = BrainzTestHelper
              .get_release('c8f7094d-ce27-365e-961f-0af27321be08')
    @brz_release = Brainz::InsertRelease.perform(release)

    # json = DiscogsTestHelper.get_discogs_data('releases', 940468)
    # release = KleinodienDiscogs.get_release(json)
    # @dc_release = Discogs::InsertRelease.perform(release)
  end

  it 'works'

  after(:all) {      DatabaseCleaner.clean }
end
