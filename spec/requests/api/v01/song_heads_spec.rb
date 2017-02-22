require 'rails_helper'
require 'api_helper'

include ApiHelper

RSpec.describe Api::V01::SongHeadsController, type: :request do
  # TODO: let the commented out test run when SongHead has an Artist
  # it 'accepts an SongHead' do
  #   api_post '/api/v01/song-heads',
  #            Hash[
  #              data: {
  #                type: 'song_heads',
  #                attributes: {
  #                  title: 'this is not a love song',
  #                  disambiguation: 'realy not'
  #                }
  #              }
  #            ]

  #   expect(response).to be_success
  #   expect(response).to have_http_status(:created)
  # end
end
