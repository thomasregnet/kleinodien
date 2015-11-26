require 'rails_helper'
require 'discogs_test_helper'

RSpec.describe Insert::Discogs::ArtistCredit, type: :model do
  context 'AC/DC' do
    before(:all) do
      json = DiscogsTestHelper.get_discogs_data('releases', 940468)
      dc_release = KleinodienDiscogs.get_release(json)
      @artist_credit = Insert::Discogs::ArtistCredit.new(dc_release.artists).run
    end

    it 'returns an ArtistCredit' do
      expect(@artist_credit).to be_instance_of(ArtistCredit)
    end

    it 'has set the right name' do
      expect(@artist_credit.name).to eq('AC/DC')
    end
  end

end
