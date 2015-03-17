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
        expect(@release.title).to eq('Highway To Hell')
        expect(@release).not_to be_new_record
      end

      it "has set the date" do
        expect(@release.date.to_s).to eq('2000-11-20')
        expect(@release.date.mask).to eq(7)
      end
      it "has imorted the songs" do
        tracks = @release.media[0].sections[0].tracks
        expect(tracks.first.release.title).to eq('Highway To Hell')
        expect(tracks[4].release.title).to    eq('Beating Around The Bush')
        expect(tracks.last.release.title).to  eq('Night Prowler')
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
        expect(@release.title).
          to eq('Dead Human Collection: 25 Years Of Death Metal')
        expect(@release).not_to be_new_record
      end

      it "has set the date" do
        expect(@release.date.to_s).to eq('2013-03-29')
        expect(@release.date.mask).to eq(7)
      end
      
      it "has imported the songs" do
        section = @release.media.first.sections.first
        tracks = section.tracks
        expect(tracks.first.release.title).to eq('Shredded Humans')
        expect(tracks.last.release.title).to  eq('Pulverized')

        section = @release.media[1].sections.first
        tracks = section.tracks
        expect(tracks.first.release.title).to eq('Devoured By Vermin')
        expect(tracks.last.release.title).to  eq('Dormant Bodies Bursting')

        section = @release.media[2].sections.first
        tracks = section.tracks
        expect(tracks.first.release.title).to eq('Decency Defied')
        expect(tracks.last.release.title).to  eq('Encased In Concrete')

        section = @release.media[3].sections.first
        tracks = section.tracks
        expect(tracks.first.release.title).to eq('A Skull Full Of Maggots')
        expect(tracks.last.release.title).to  eq('Scourge Of Iron')

        # 12", Picture Disc
        section = @release.media[4].sections[0]
        tracks = section.tracks
        expect(tracks.first.release.title).to eq('A Skull Full Of Maggots')
        expect(tracks.last.release.title).to  eq('I Will Kill You')

        section = @release.media[4].sections[1]
        tracks = section.tracks
        expect(tracks.first.release.title).to eq('Pounded Into Dust')
        expect(tracks.last.release.title).to  eq('Scourge Of Iron')
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

      it "has set the date" do
        expect(@release.date.to_s).to eq('1972-01-01')
        expect(@release.date.mask).to eq(4)
      end

      it "has imported the songs" do
        section = @release.media[0].sections[0]
        tracks = section.tracks
        expect(tracks.first.release.title).to eq('The System')
        expect(tracks.last.release.title).to  eq('The Seventh Seal')

        section = @release.media[0].sections[1]
        tracks = section.tracks
        expect(tracks.first.release.title).to eq('Aegian Sea')
        expect(tracks.last.release.title).to  eq('Ofis')

        section = @release.media[1].sections[0]
        tracks = section.tracks
        expect(tracks.first.release.title).to eq('Seven Trumpets')
        expect(tracks.last.release.title).to  eq('Hic Et Nunc')

        section = @release.media[1].sections[1]
        tracks = section.tracks
        expect(tracks.first.release.title).
          to eq('All The Seats Were Occupied')
        expect(tracks.last.release.title).to  eq('Break')
      end
      
      after(:all) { DatabaseCleaner.clean }
    end
  end
end
