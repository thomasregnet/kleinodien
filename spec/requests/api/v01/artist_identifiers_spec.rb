require 'rails_helper'
require 'api_helper'

include ApiHelper

RSpec.describe Api::V01::ArtistsController, type: :request do
  it 'sends a list of artist identifiers' do
    FactoryGirl.create_list(:artist_identifier, 2)

    api_get '/api/v01/artist-identifiers'

    expect(response).to be_success
  end

  it 'accepts an artist identifier' do
    artist = FactoryGirl.create(:artist)
    source = FactoryGirl.create(:source)

    api_post '/api/v01/artist-identifiers',
             Hash[
               data: {
                 type: 'artist-identifiers',
                 attributes: {
                   value: 'fake-artist-identifier-value'
                 },
                 relationships: {
                   artist: {
                     data: { type: 'artists', id: artist.id }
                   },
                   source: {
                     data: { type: 'sources', id: source.id }
                   }
                 }
               }
             ]

    expect(response).to be_success
    expect(response).to have_http_status(:created)
  end
end
