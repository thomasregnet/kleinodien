require 'rails_helper'
require 'api_helper'

include ApiHelper

RSpec.describe Api::V01::ArtistsController, type: :request do
  it 'sends a list of artists' do
    a = FactoryBot.create_list(:artist, 2)

    api_get '/api/v01/artists'

    expect(response).to be_success

    expect(json['data'].length).to eq 2
  end

  it 'accepts an artist' do
    api_post '/api/v01/artists',
             Hash[
               data: {
                 type: 'artists',
                 attributes: {
                   name: 'ACDC'
                 }
               }
             ]

    expect(response).to be_success
    expect(response).to have_http_status(:created)
  end
end
