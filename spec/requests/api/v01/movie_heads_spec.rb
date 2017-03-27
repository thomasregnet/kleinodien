require 'rails_helper'
require 'api_helper'

include ApiHelper

RSpec.describe Api::V01::MovieHeadsController, type: :request do
  it 'accepts an MovieHead' do
    api_post( '/api/v01/movie-heads',
             Hash[
               data: {
                 type: 'movie_heads',
                 attributes: {
                   title:          'some movie',
                   disambiguation: 'distict from the others'
                 }
               }
             ]
            )
    #byebug
    puts response.body
    expect(response).to be_success
    expect(response).to have_http_status(:created)
  end
end
