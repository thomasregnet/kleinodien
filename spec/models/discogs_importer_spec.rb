require 'rails_helper'
require 'discogs_test_helper'

RSpec.describe DiscogsImporter, type: :model do
  describe "import releases" do
    context "import a CD release of one artist (AC/DC Highway To Hell)" do
      before(:all) do
        DatabaseCleaner.start
        @release = DiscogsTestHelper.import_release(940468)
      end
      
      it "has imported the album" do
        expect(@release).to be_valid
        expect(@release.head.title).to eq('Highway To Hell')
        expect(@release).not_to be_new_record
      end

      it "has imorted the songs" do
        tracks = @release.media[0].sections[0].tracks
        expect(tracks.first.release.head.title).to eq('Highway To Hell')
        expect(tracks[4].release.head.title).to    eq('Beating Around The Bush')
        expect(tracks.last.release.head.title).to  eq('Night Prowler')
      end

      after(:all) { DatabaseCleaner.clean }
    end

    context "import a Compilation (Cannibal Corpse - Dead Human Collection)" do
      before(:all) do
        DatabaseCleaner.start
        @release = DiscogsTestHelper.import_release(4462260)
      end
      
      it "has imported the album" do
        expect(@release).to be_valid
        expect(@release.head.title).
          to eq('Dead Human Collection: 25 Years Of Death Metal')
        expect(@release).not_to be_new_record
      end

      it "has imported the songs" do
        section = @release.media.first.sections.first
        expect(section.tracks.first.release.head.title).to eq('Shredded Humans')
      end

      after(:all) { DatabaseCleaner.clean }
    end

    context "import a double album (Aphrodite's Child - 666)" do
      before(:all) do
        DatabaseCleaner.start
        @release = DiscogsTestHelper.import_release(4298844)
      end

      it "has imported the album" do
        expect(@release).not_to be_new_record
      end

      it "has the song 'Hit Et Nunc' at medium two side two" do
        track = @release.media[1].sections[1].tracks[0]
        expect(track.release.head.title).to eq('All The Seats Were Occupied')
      end

      after(:all) { DatabaseCleaner.clean }
    end
  end
end
