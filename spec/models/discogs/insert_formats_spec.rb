require 'rails_helper'
require 'discogs_test_helper'

RSpec.describe Discogs::InsertFormats, type: :model do
  context 'Dead Human Collection' do
    before(:all) do
      DatabaseCleaner.start
      
      json = DiscogsTestHelper.get_discogs_data('releases', 4462260)
      dc_release = KleinodienDiscogs.get_release(json)
      @album_release = Discogs::InsertRelease.perform(dc_release)
      @formats = @album_release.formats
    end

    it 'has the formats set' do
      expect(@formats[0].name).to eq('foo')
    end

    after(:all) { DatabaseCleaner.clean }
  end
end
