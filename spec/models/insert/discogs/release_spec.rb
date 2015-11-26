require 'rails_helper'
require 'discogs_test_helper'

RSpec.describe Insert::Discogs::Release, type: :model do
  context 'Highway To Hell' do
    before(:all) do
      json = DiscogsTestHelper.get_discogs_data('releases', 940468)
      dc_release = KleinodienDiscogs.get_release(json)
      @release = Insert::Discogs::Release.new(dc_release)
    end

    it 'responds to "run"' do
      expect(@release).to respond_to(:run)
    end

    it 'returns an AlbumRelease' do
      expect(@release.run).to be_instance_of(AlbumRelease)
    end
  end
end
