require 'rails_helper'
require 'discogs_test_helper'

RSpec.describe Discogs::InsertRelease, type: :model do
  context 'interface' do
    before (:each) do
      @insert_release = Discogs::InsertRelease.new('dummy data')
    end

    it 'responds to "perform"' do
      expect(@insert_release).to respond_to(:perform)
    end

    specify 'class Discogs::InsertRelease responds to "perform"' do
      expect(Discogs::InsertRelease).to respond_to(:perform)
    end
  end

  context 'AC/DC - Highway To Hell' do
    before(:all) do
      DatabaseCleaner.start
      
      json = DiscogsTestHelper.get_discogs_data('releases', 940468)
      dc_release = KleinodienDiscogs.get_release(json)
      @release = Discogs::InsertRelease.perform(dc_release)
    end

    it 'returns an AlbumRelease' do
      expect(@release).to be_instance_of(AlbumRelease)
    end

    it 'has the country set' do
      expect(@release.countries[0].name).to eq('Germany')
    end
    
    after(:all) do
      DatabaseCleaner.clean
    end
  end
end
