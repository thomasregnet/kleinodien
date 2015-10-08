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

        expect(@movie_head.countries.length).to eq(1)
        expect(@movie_head.countries[0].name).to eq('NZ')

        expect(@movie_head.credits.length).to eq(19)
        
        expect(@movie_head.credits[0].artist_credit.name).to eq('Peter Jackson')
        expect(@movie_head.credits[0].role).to be_nil
        expect(@movie_head.credits[0].job.name).to eq('Director')

        expect(@movie_head.credits[18].artist_credit.name).to eq('Lewis Rowe')
        expect(@movie_head.credits[18].role).to eq('Mr. Matheson')
        expect(@movie_head.credits[18].job.name).to eq('Akteur')
      end

      after(:all) do
        DatabaseCleaner.clean
      end
    end
  end
end
