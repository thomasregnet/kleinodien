require 'rails_helper'
require 'discogs_test_helper'

RSpec.describe DiscogsImporter, type: :model do
  describe "import releases" do
    context "import a CD release of one artist (AC/DC Highway to Hell)" do
      before do
        json = DiscogsTestHelper.get_discogs_release_data(940468)
        @release = DiscogsImporter.import_release(json)
      end

      it "has imported the album" do
        expect(@release).to be_instance_of(AlbumRelease)
        expect(@release).not_to be_new_record
      end
    end

    context "import a Compilation (Cannibal Corpse - Dead Human Collection)" do
      before do
        json = DiscogsTestHelper.get_discogs_release_data(4462260)
        @release = DiscogsImporter.import_release(json)
      end

      it "has imported the album" do
        expect(@release).to be_instance_of(AlbumRelease)
        expect(@release).not_to be_new_record
        byebug
      end
    end
  end
end
