require 'rails_helper'
require 'api_helper'

include ApiHelper

#RSpec.describe 'Artists API' do
RSpec.describe Api::V01::ArtistsController, :type => :controller do
  it 'sends a list of artists' do
    FactoryGirl.create_list(:artist, 2)

    #api_get '/api/v01/artists'
    get :index

    expect(response).to be_success

    expect(json['data'].length).to eq 2
  end

  it 'accepts an artist' do
    data = <<-JSON
    {
      "type": "artists",
      "data": {
          "attributes": {
              "disambiguation": null,
              "name": "AC/DC",
              "source-ident": "66c662b6-6e2f-4930-8610-912e24c63ed1",
              "source-name": "MusicBrainz"
         }
      }
    }
    JSON

    # post '/api/v01/artists',
    #      { "data": {} },
    #      params: data,
    #      headers: {
    #        #'Accept'       => 'application/vnd.api+json',
    #        'Content-Type' => 'application/vnd.api+json'
    #      } #,as: :json
    headers = { 'Content-Type' => 'application/vnd.api+json' }
    request.headers.merge! headers
    data = { data: {} }.to_json
    puts data
    post :create, params: {
           data: {
             type: 'artists',
             attributes: {
               name: 'AC/DC'
             }
           },
           type: 'artists'
         }
         # headers: { 
         #   #'Content-Type' => 'application/vnd.api+json'
         #   #'CONTENT_TYPE' =>  'application/vnd.api+json'
         # }

    #byebug
    expect(response).to be_success
  end
end
