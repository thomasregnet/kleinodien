require 'rails_helper'
require 'ko_test_data'

# TODO: Why do i need to require this modules
require 'import/prepare_brainz_compilation_release'
require 'import/prepare_brainz_artist'
require 'import/prepare_brainz_artist_credit'


RSpec.describe Import::BrainzCompilationRelease do
  context 'without konwledge' do
    describe '.perform' do
      brainz_id = '404e67be-0b5e-47bc-81db-1e8c408e9e3f'
      data = {
        data: {
          type: 'music-brainz-release',
          attributes: {
            wanted: brainz_id
          }
        }
      }

      response = described_class.perform(params: data)

      it 'returns a http status code of 202' do
        expect(response.dig(:data, :attributes, :http_status_code)).to eq(202)
      end

      it 'requires the release data' do
        ref_key = response.dig(:data, :attributes, :required, :brainz)[0]
        reference = BrainzReleaseRef.new(code: brainz_id)
        expect(ref_key).to eq(reference.to_key)
      end
    end
  end

  context 'with knowledge of the release' do
    brainz_id = '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a'
    reference = BrainzReleaseRef.new(code: brainz_id)
    response = described_class.perform(
      params:
      Hash[
        data: {
          type: 'music-brainz-release',
          attributes: {
            wanted: brainz_id,
            known: {
              brainz: {
                reference.to_key => KoTestData.brainz_release(reference)
              }
            }
          }
        }
      ]
    )
    it 'returns a http status code of 202' do
      expect(response.dig(:data, :attributes, :http_status_code)).to eq(202)
    end

    it 'does not require the release data' do
      required = response.dig(:data, :attributes, :required, :brainz)
      expect(required).not_to include(reference.to_key)
    end
  end
end
