require 'rails_helper'

RSpec.describe Import::BrainzCompilationRelease, type: :model do
  it 'returns required params' do
    reference = '404e67be-0b5e-47bc-81db-1e8c408e9e3f'
    data = {
      data: {
        type: 'music-brainz-release',
        attributes: {
          wanted: reference
        }
      }
    }

    response = Import::BrainzCompilationRelease.perform(params: data)

    expect(response[:data][:attributes][:http_status_code]).to eq(202)
    #byebug
    ref_key = response[:data][:attributes][:required][:brainz][0]
    expected_ref_key = 'release/'\
                   "#{reference}"\
                   '?inc=artists+labels+recordings+release-groups'
    expect(ref_key).to eq(expected_ref_key)
  end

  specify 'Sepultura - Arise' do
    reference = '7452f8c9-f9bc-3ca7-859e-3220e57e4e4'
    response = Import::BrainzCompilationRelease.perform(params: 
      Hash[
        data: {
          type: 'music-brainz-release',
          attributes: {
            wanted: reference,
            known: {
              musicbrainz: [
                {
                  type: 'release',
                  id: reference,
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
