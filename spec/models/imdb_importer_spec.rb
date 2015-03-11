require 'rails_helper'
require 'imdb_test_helper'

RSpec.describe ImdbImporter, type: :model do
  context "importing a movie" do
    before(:all) do
      html        = ImdbTestHelper.get_movie_data('tt0079470.html')
      @movie_head = ImdbImporter.import_movie(html)
    end

    it "has the right title" do
      expect(@movie_head.title).to eq('Life of Brian')
    end

    it "has the right class" do
      expect(@movie_head).to be_instance_of(MovieHead)
    end

    after(:all) do
      @movie_head.delete
    end
  end

  context "importing a tv serial" do
    before(:all) do
      html    = ImdbTestHelper.get_movie_data('tt0106179.html')
      @tv_serial = ImdbImporter.import_tv_serial(html)
    end

    it "has the right title" do
      expect(@tv_serial.title).to eq('"The X Files"')
    end
    
    after(:all) do
      @tv_serial.delete
    end
  end
end
