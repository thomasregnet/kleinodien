require 'rails_helper'
require 'discogs_test_helper'

RSpec.describe Insert::Discogs::Release, type: :model do
  context 'Highway To Hell' do
    before(:all) do
      json = DiscogsTestHelper.get_discogs_data('releases', 940468)
      @release = Insert::Discogs::Release.new(json)
    end

    it 'responds to "run"' do
      expect(@release).to respond_to(:run)
    end

    it 'returns a kleinodien_discogs-release' do
      expect(@release.run).to be_instance_of(KleinodienDiscogs::Release)
    end
  end
end
