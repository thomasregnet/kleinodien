require 'rails_helper'
require 'discogs_test_helper'

RSpec.describe DiscogsImporter, type: :model do
  describe "import releases" do
    context "import a CD release of one artist (AC/DC Highway to Hell)" do
      let(:release) { DiscogsTestHelper.import_release(940468) }
      it "has imported the album" do
        expect(release).to be_instance_of(AlbumRelease)
        expect(release).not_to be_new_record
      end
    end

    context "import a Compilation (Cannibal Corpse - Dead Human Collection)" do
      let(:release) { DiscogsTestHelper.import_release(4462260) }

      it "has imported the album" do
        expect(release).to be_instance_of(AlbumRelease)
        expect(release).not_to be_new_record
      end
    end

    context "import a double album (Aphrodite's Child - 666)" do
      let(:release) { DiscogsTestHelper.import_release(4298844) }

      it "has imported the album" do
        expect(release).not_to be_new_record
      end

      it "has the song 'Hit Et Nunc' at medium two side two" do
        track = release.media[1].sections[1].tracks[0]
        expect(track.release.head.title).to eq('All The Seats Were Occupied')
      end
    end
  end
end
