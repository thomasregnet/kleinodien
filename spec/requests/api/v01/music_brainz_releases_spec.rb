require 'rails_helper'
require 'api_helper'

include ApiHelper

RSpec.describe Api::V01::MusicBrainzReleasesController do
  it 'accepts a request to import an MusicBraiz-release' do
    api_post '/api/v01/music_brainz_releases',
             Hash[
               data: {
                 type: 'music-brainz-releases',
                 attributes: {
                   wanted: 'b3b2ee43-57d4-4f82-b14a-999fd46821de'
                 }
               }
             ]
    expect(response).to have_http_status(202)
    expect(response.content_type).to eq 'application/vnd.api+json'
  end
end
