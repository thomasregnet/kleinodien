require 'rails_helper'
require 'discogs_test_helper'

RSpec.describe Discogs::InsertExtraartists, type: :model do
  context 'AC/DC - Highway To Hell' do
    before(:all) do
      DatabaseCleaner.start
      
      json = DiscogsTestHelper.get_discogs_data('releases', 940468)
      dc_release = KleinodienDiscogs.get_release(json)
      @release = Discogs::InsertRelease.perform(dc_release)
    end

    it 'has the extraartists set' do
      
    end

    after(:all) { DatabaseCleaner.clean }
  end
end
