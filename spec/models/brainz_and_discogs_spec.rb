require 'rails_helper'
require 'brainz_test_helper'
require 'discogs_test_helper'

RSpec.describe 'insert a release from Discogs and MusicBrainz' do
  describe 'Highway To Hell' do
    before(:all) do
      DatabaseCleaner.start

      release = BrainzTestHelper
                .get_release('c8f7094d-ce27-365e-961f-0af27321be08')
      @brz_release = Brainz::InsertRelease.perform(release)

      json = DiscogsTestHelper.get_discogs_data('releases', 940_468)
      release = KleinodienDiscogs.get_release(json)
      @dc_release = Discogs::InsertRelease.perform(release)
    end

    it 'works'

    after(:all) { DatabaseCleaner.clean }
  end

  # TODO: make test with "Judgement Night" from Brainz and Discogs work again
  # This test fails because of the many equal Artist-Names without from
  # two sources. The "Highway to Hell"-Tests passes because of the
  # "disambiguation" in for "AC/DC" in Brainz-data.
  # describe 'Judgment Night' do
  #   before(:all) do
  #     DatabaseCleaner.start

  #     brz_release = BrainzTestHelper
  #                   .get_release('f966b30a-a0bc-4234-bea6-7b93a1083276')
  #     @brz_release = Brainz::InsertRelease.perform(brz_release)

  #     json = DiscogsTestHelper.get_discogs_data('releases', 612_384)
  #     dc_release = KleinodienDiscogs.get_release(json)
  #     @dc_release = Discogs::InsertRelease.perform(dc_release)
  #   end

  #   it 'works'

  #   after(:all) { DatabaseCleaner.clean }
  # end
end
