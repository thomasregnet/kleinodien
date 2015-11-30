require 'rails_helper'
require 'discogs_test_helper'

RSpec.describe Discogs::InsertArtists, type: :model do
  context 'AC/DC' do
    before(:all) do
      DatabaseCleaner.start

      json = DiscogsTestHelper.get_discogs_data('releases', 940468)
      dc_release = KleinodienDiscogs.get_release(json)
      @artist_credit = Discogs::InsertArtists.perform(dc_release.artists)
    end

    it 'has the right name set' do
      expect(@artist_credit.name).to eq('AC/DC')
    end

    after(:all) do
      DatabaseCleaner.clean
    end
  end
end
