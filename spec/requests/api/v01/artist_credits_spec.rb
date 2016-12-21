require 'rails_helper'
require 'api_helper'

include ApiHelper

RSpec.describe Api::V01::ArtistCreditsController, :type => :request do
  context '#get' do
    before(:all) do
      DatabaseCleaner.start
      @credits = FactoryGirl.create_list(:artist_credit, 2)
    end

    it 'sends a list of artist_credits' do
      headers = {
        'Accept'       => 'application/vnd.api+json'
      }
      get '/api/v01/artist-credits', headers: headers

      expect(response).to be_success

      expect(json['data'].length).to eq 2
    end

    it 'sends a list of artist_credits with participants' do
      id = @credits.first.id
      get "/api/v01/artist-credits/#{id}?include=participants",
          headers: { 'Accept' => 'application/vnd.api+json' }

      #byebug
      expect(response).to be_success
    end
  end

  after(:all) do
    DatabaseCleaner.clean
  end
end
