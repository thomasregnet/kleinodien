require 'rails_helper'
require 'api_helper'

RSpec.describe Api::Import::BrainzReleasesController, type: :request do
  it 'takes an MusicBrainz release' do
    post(
      '/api/import/brainz_releases',
      headers: { 'Content-Type' => 'application/json' },
      params:  { data: '<brainz>data</brainz>' }.to_json
    )

    expect(response).to be_success
  end
end
