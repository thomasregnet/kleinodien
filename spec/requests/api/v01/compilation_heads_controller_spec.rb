require 'rails_helper'
require 'api_helper'

include ApiHelper

RSpec.describe Api::V01::CompilationHeadsController, type: :request do
  it 'sends a list of piece_heads' do
    FactoryGirl.create(:album_head)
    FactoryGirl.create(:album_head)

    api_get '/api/v01/compilation-heads'

    expect(response).to be_success

    expect(json['data'].length).to eq 2
  end
end
