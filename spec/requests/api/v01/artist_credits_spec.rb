require 'rails_helper'
require 'api_helper'

include ApiHelper

RSpec.describe Api::V01::ArtistsController, :type => :controller do
  it 'sends a list of artist_credits' do
    FactoryGirl.create_list(:artist_credit, 2)

    get :index

    expect(response).to be_success

    expect(json['data'].length).to eq 2
  end
end
