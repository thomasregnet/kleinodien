# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_import_requests'
require 'shared_examples_for_code_uuid_validations'
require 'shared_examples_for_import_state_transitions'

RSpec.describe BrainzAreaImportRequest, type: :model do
  it_behaves_like(
    'an import state transitions capable object',
    :brainz_area_import_request
  )

  include_examples 'for ImportRequests', :brainz_area_import_request
  include_examples(
    'for code fields that must be an uuid',
    :brainz_area_import_request
  )

  describe '#to_uri' do
    let(:code) { 'ffbda5be-f688-11e9-9b8d-77af99135d8c' }
    let(:import_request) do
      FactoryBot.build(:brainz_area_import_request, code: code)
    end
    let(:expected_uri) do
      "https://musicbrainz.org/ws/2/area/#{code}?inc=aliases"
    end

    it 'returns the uri' do
      expect(import_request.to_uri).to eq(expected_uri)
    end
  end
end
