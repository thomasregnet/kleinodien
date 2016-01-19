require 'rails_helper'
require 'discogs_test_helper'

RSpec.describe Discogs::InsertTracklist, type: :model do
  context 'Jello Biafra With Nomeansno - The Sky is Fallin And ...' do
    before(:all) do
      DatabaseCleaner.start

      json = DiscogsTestHelper.get_discogs_data('releases', 1083888)
      dc_release = KleinodienDiscogs.get_release(json)
      @album_release = FactoryGirl.create(:album_release)
      Discogs::InsertTracklist.perform(dc_release.tracklist, @album_release)
      @tracks = @album_release.tracks
    end

    it 'has inserted the tracks and its extraartists' do
      track = @tracks[0]
      expect(track.release.title)
        .to eq('The Sky Is Falling, And I Want My Mommy (Falling Space Junk)')
      credit = track.release.credits[0]
      expect(credit.artist_credit.name).to eq('Nomeansno')

      credit = @tracks[1].release.credits[0]
      expect(credit).to be_nil

      track = @tracks[2]
      expect(track.release.title).to eq("Bruce's Diary")
      credits = track.release.credits
      expect(credits[0].artist_credit.name).to eq('John Wright')

      expect(credits[1].artist_credit.name).to eq('The Totaliterrortones')
      expect(credits[1].job.name).to eq('Horns')
    end

    after(:all) { DatabaseCleaner.clean }
  end
end
