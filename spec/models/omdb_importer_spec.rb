# coding: utf-8
require 'rails_helper'
require 'omdb_test_helper'

RSpec.describe OmdbImporter, type: :model do
  describe "import movies" do
    context "Braindead" do
      before(:all) do
        DatabaseCleaner.start
        @movie_head = OmdbTestHelper.import_movie(763)
      end

      specify "was imported" do
        expect(@movie_head.title)
          .to eq('Braindead - Der Zombie-Rasenmähermann')

        expect(@movie_head.credits.length).to eq(19)
      end

      after(:all) do
        DatabaseCleaner.clean
      end
    end
  end
end
