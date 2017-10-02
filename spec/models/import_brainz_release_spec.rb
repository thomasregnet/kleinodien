require 'rails_helper'

RSpec.describe ImportBrainzRelease, type: :model do
  it 'returns required params' do
    brainz_id = '404e67be-0b5e-47bc-81db-1e8c408e9e3f'
    data = {
      data: {
        type: 'music-brainz-release',
        attributes: {
          wanted: brainz_id
        }
      }
    }

    response = ImportBrainzRelease.perform(data, ImportCache.new)

    # TODO: check response status
    # expect(response.status).to eq 202

    params = JSON.parse(response, symbolize_names: true)
    required = params[:data][:attributes][:required][:musicbrainz][0]
    required_attrs = required[:attributes]

    expect(required[:id]). to eq brainz_id
    expect(required_attrs[:path]). to eq "release/#{brainz_id}"
    expect(required_attrs[:url])
      .to eq "http://musicbrainz.org/ws/2/release/#{brainz_id}"
  end

  specify 'Sepultura - Arise' do
    brainz_id = '7452f8c9-f9bc-3ca7-859e-3220e57e4e4'
    response = ImportBrainzRelease.perform(
      Hash[
        data: {
          type: 'music-brainz-release',
          attributes: {
            wanted: brainz_id,
            known: {
              musicbrainz: [
                {
                  type: 'release',
                  id: brainz_id,
                  attributes: {
                    query_result: '<xml></xml>'
                  }
                }
              ]
            }
          }
        }
      ],
      ActionDispatch::Response.new
    )
    # TODO: check response status
    # expect(response.status).to eq 202

    # TODO: :wanted must not contain the release
  end
end
