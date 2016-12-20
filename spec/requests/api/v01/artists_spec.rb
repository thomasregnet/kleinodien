require 'rails_helper'
require 'api_helper'

include ApiHelper

RSpec.describe Api::V01::ArtistsController, :type => :controller do
  it 'sends a list of artists' do
    FactoryGirl.create_list(:artist, 2)

    get :index

    expect(response).to be_success

    expect(json['data'].length).to eq 2
  end

  it 'accepts an artist' do
    set_request_content_type_to_vnd_api_json
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
