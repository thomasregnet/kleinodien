# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

# rubocop:disable Metrics/BlockLength
RSpec.describe BrainzFetcher do
  it_behaves_like 'a service'

  context 'with a valid ImportOrder' do
    def brainz_code
      '2280ca0e-6968-4349-8c36-cb0cbd6ee95f'
    end

    let(:uri) do
      'https://musicbrainz.org/ws/2/artist/' \
        + brainz_code \
        + '?inc=url-rels'
    end

    let(:import_request) do
      FactoryBot.build(
        :brainz_artist_import_request,
        code: brainz_code
      )
    end

    it 'returns a BrainzBlueprint' do
      expect(described_class.call(import_request: import_request))
        .to be_instance_of(BrainzBlueprint)
    end

    it 'saves the response body' do
      described_class.call(import_request: import_request)
      expect(import_request.body.content).not_to be_blank
    end
  end

  context "when data can't be requested" do
    def brainz_code
      '60ede5a2-ed6f-11e8-8b18-df985781dfef'
    end

    let(:import_request) do
      FactoryBot.build(:brainz_artist_import_request, code: brainz_code)
    end

    it 'raises an error' do
      expect { described_class.call(import_request: import_request) }
        .to raise_error(ImportError::CanNotFetch, /#{brainz_code}/)
    end
  end
end
# rubocop:enable Metrics/BlockLength
