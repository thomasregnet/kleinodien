require 'rails_helper'

RSpec.describe ImportBrainzRelease, type: :model do
  it 'returns required data' do
    brainz_id = '404e67be-0b5e-47bc-81db-1e8c408e9e3f'
    response = ImportBrainzRelease.perform(
      Hash[
        data: {
          type: 'music-brainz-release',
          attributes: {
            wanted: brainz_id
          }
        }
      ],
      ActionDispatch::Response.new
    )

    expect(response).to be_instance_of ActionDispatch::Response
    expect(response.status).to eq 202

    data = JSON.parse(response.body, symbolize_names: true)[:data]
    required = data[:attributes][:required][:musicbrainz][0]
    required_attrs = required[:attributes]

    expect(required[:id]). to eq brainz_id
    expect(required_attrs[:path]). to eq "release/#{brainz_id}"
    expect(required_attrs[:url])
      .to eq "http://musicbrainz.org/ws/2/release/#{brainz_id}"
  end
end
