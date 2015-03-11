require 'rails_helper'
require 'imdb_test_helper'

RSpec.describe ImdbImporter, type: :model do
  context "Life of Brian" do
    let(:html) { ImdbTestHelper.get_movie_data('tt0079470.html') }
    let(:movie_head) { ImdbImporter.import_movie(html) }

    it "should have the right title" do
      expect(movie_head.title).to eq('Life of Brian')
    end
  end
end
