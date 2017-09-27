require 'rails_helper'
require 'api_helper'

include ApiHelper

RSpec.describe Api::V01::MusicBrainzReleasesController do
  it 'accepts a request to import an MusicBraiz-release' do
    api_post '/api/v01/music_brainz_releases',
             Hash[
               data: { type: 'music-brainz-releases'}
             ]
  end
end
