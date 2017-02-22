require 'rails_helper'
require 'api_helper'

include ApiHelper

RSpec.describe Api::V01::PieceHeadsController, type: :request do
  it 'sends a list of piece_heads' do
    FactoryGirl.create(:episode_head)
    FactoryGirl.create(:movie_head)
    FactoryGirl.create(:song_head)

    a = api_get '/api/v01/piece-heads'

    expect(response).to be_success

    expect(json['data'].length).to eq 3
  end
end
