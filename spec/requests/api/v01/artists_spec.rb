require 'rails_helper'

RSpec.describe 'Artists API' do
  it 'sends a list of artists' do
    FactoryGirl.create_list(:artist, 2)

    get '/api/v01/artists',
        headers: { 'Accept' => 'application/vnd.api+json' }

    expect(response).to be_success

    json = JSON.parse(response.body)
    expect(json['data'].length).to eq 2
  end
end
