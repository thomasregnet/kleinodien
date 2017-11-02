require 'rails_helper'

RSpec.describe Import::BrainzCompilationRelease, type: :model do
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

    response = Import::BrainzCompilationRelease.perform(params: data)

    expect(response[:data][:attributes][:http_status_code]).to eq(202)
    cache_key = response[:data][:attributes][:required]['brainz'][0]
    expected_cache_key = 'release/'\
                   "#{brainz_id}"\
                   '?inc=artists+labels+recordings+release-groups'
    expect(cache_key).to eq(expected_cache_key)
  end

  specify 'Sepultura - Arise' do
    brainz_id = '7452f8c9-f9bc-3ca7-859e-3220e57e4e4'
    response = Import::BrainzCompilationRelease.perform(params: 
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
      ]
    )
    # TODO: check response status
    # expect(response.status).to eq 202

    # TODO: :wanted must not contain the release
  end
end
