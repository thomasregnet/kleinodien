require 'rails_helper'
require 'discogs_test_helper'

RSpec.describe Discogs::InsertTracklist, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  context 'AC/DC - Highway To Hell' do
    before(:all) do
      DatabaseCleaner.start
      
      json = DiscogsTestHelper.get_discogs_data('releases', 940468)
      dc_release = KleinodienDiscogs.get_release(json)
      @album_release = FactoryGirl.create(:album_release)
      #@release = Discogs::InsertRelease.perform(dc_release)
      Discogs::InsertTracklist.perform(dc_release.get_media, @album_release)
      @tracks = @album_release.tracks
    end

    it 'has the tracks set' do
      track = @tracks[0]
      expect(track.position).to eq('1')
      expect(track.release.title).to eq('Highway To Hell')

      track = @tracks[4]
      expect(track.position).to eq('5')
      expect(track.release.title).to eq('Beating Around The Bush')
      
      track = @tracks[9]
      expect(track.position).to eq('10')
      expect(track.release.title).to eq('Night Prowler')      
    end
    
    after(:all) { DatabaseCleaner.clean }
  end
end
