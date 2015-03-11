require 'rails_helper'
require 'imdb_test_helper'

RSpec.describe ImdbImporter, type: :model do
  context "Life of Brian" do
    before(:all) do
      html       = ImdbTestHelper.get_movie_data('tt0079470.html')
      @movie_head = ImdbImporter.import_movie(html)
    end

    it "should have the right title" do
      expect(@movie_head.title).to eq('Life of Brian')
    end

    it "has the right class" do
      expect(@movie_head).to be_instance_of(MovieHead)
    end

    after(:all) do
      @movie_head.delete
    end
  end
end
