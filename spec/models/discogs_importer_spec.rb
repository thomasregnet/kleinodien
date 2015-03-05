require 'rails_helper'
require 'discogs_test_helper'

RSpec.describe DiscogsImporter, type: :model do
  describe "import releases" do
    context "import a CD release of one artist"

    DatabaseCleaner.start
    
    json = DiscogsTestHelper.get_discogs_release_data('940468.json')
    release = DiscogsImporter.import_release(json)

    it "has imported the album" do
      expect(release).to be_instance_of(AlbumRelease)
    end

    DatabaseCleaner.clean
  end
end
