# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_import_requests'
require 'shared_examples_for_code_uuid_validations'

RSpec.describe BrainzCompanyImportRequest, type: :model do
  include_examples 'for ImportRequests', :brainz_company_import_request
  include_examples(
    'for code fields that must be an uuid',
    :brainz_company_import_request
  )

  def uuid
    @uuid ||= SecureRandom.uuid.to_s
  end

  describe '#to_uri' do
    let(:import_request) { described_class.new(code: uuid) }

    let(:expected_uri) do
      "https://musicbrainz.org/ws/2/label/#{uuid}"
    end

    it 'returns the uri' do
      expect(import_request.to_uri).to eq(expected_uri)
    end
  end
end
