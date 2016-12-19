require 'rails_helper'
require 'api_helper'

include ApiHelper

#RSpec.describe 'Artists API' do
RSpec.describe Api::V01::ArtistsController, :type => :controller do
  it 'sends a list of artists' do
    FactoryGirl.create_list(:artist, 2)

    get :index

    expect(response).to be_success

    expect(json['data'].length).to eq 2
  end

  it 'accepts an artist' do
    headers = { 'Content-Type' => 'application/vnd.api+json' }
    request.headers.merge! headers
    post :create, params: {
           data: {
             type: 'artists',
             attributes: {
               name: 'AC/DC'
             }
           },
         }

    expect(response).to be_success
  end
end
