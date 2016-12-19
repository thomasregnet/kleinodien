require 'rails_helper'
require 'api_helper'

include ApiHelper

RSpec.describe 'Artists API' do
  it 'sends a list of artists' do
    FactoryGirl.create_list(:artist, 2)

    api_get '/api/v01/artists'

    expect(response).to be_success

    expect(json['data'].length).to eq 2
  end
end
