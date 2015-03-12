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
      DatabaseCleaner.start
      html    = ImdbTestHelper.get_movie_data('tt0106179.html')
      @tv_serial = ImdbImporter.import_tv_serial(html)

      season_html = ImdbTestHelper.get_season_data('tt0106179-1.html')
      @season = ImdbImporter.import_tv_serial_season(@tv_serial, 1, season_html)
    end

    it "has the right title" do
      expect(@tv_serial.title).to eq('"The X Files"')
    end

    it "has imported the seasons" do
      expect(@tv_serial.seasons.count).to eq(1)
    end

    it "has imported the episodes" do
      expect(@tv_serial.seasons.first.episodes.count).to eq(24)
    end

    it "has imported the episodes" do
      expect(@tv_serial.seasons.first.episodes[0].title).to eq('Pilot')
      expect(@tv_serial.seasons.first.episodes[0].no).to eq(0)

      expect(@tv_serial.seasons.first.episodes[9].title).to eq('Fallen Angel')
      expect(@tv_serial.seasons.first.episodes[9].no).to eq(9)

      expect(@tv_serial.seasons.first.episodes.last.title).
        to eq('The Erlenmeyer Flask')
      expect(@tv_serial.seasons.first.episodes.last.no).to eq(23)
    end
    
    after(:all) do
      DatabaseCleaner.clean
    end
  end
end
