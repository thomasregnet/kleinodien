require 'rails_helper'
require 'api_helper'

include ApiHelper

RSpec.describe Api::V01::ArtistCreditsController, type: :request do
  context '#get' do
    before(:all) do
      DatabaseCleaner.start
      @credits = FactoryBot.create_list(:artist_credit, 2)
    end

    it 'sends a list of artist_credits' do
      api_get '/api/v01/artist-credits'

      expect(response).to be_success

      expect(json_data.length).to eq 2
    end

    # it 'sends a list of artist_credits with participants' do
    #   id = @credits.first.id
    #   api_get "/api/v01/artist-credits/#{id}?include=participants"

    #   expect(response).to be_success
    #   byebug
    #   expect(json_included[0]['type']).to eq 'participants'
    # end
  end

  after(:all) do
    DatabaseCleaner.clean
  end
end
