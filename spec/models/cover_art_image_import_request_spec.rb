# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_code_uuid_validations'
require 'shared_examples_for_import_requests'

RSpec.describe CoverArtImageImportRequest, type: :model do
  include_examples 'for ImportRequests', :brainz_release_import_request
  include_examples(
    'for code fields that must be an uuid',
    :brainz_release_import_request
  )

  # rubocop:disable RSpec/LetBeforeExamples
  let(:code) { 'b4bdc9c6-a3c0-4e50-a6f5-fe6ec5e66609' }
  let(:import_request) { FactoryBot.build(:cover_art_image_import_request, uri: uri) }
  let(:uri) { "http://coverartarchive.org/release/#{code}/1232339678.jpg" }
  # rubocop:enable RSpec/LetBeforeExamples

  context 'without a code' do
    it 'extracts the code from the uri' do
      import_request.code = nil
      import_request.valid?
      # expect(import_request.code).to eq('58e6a3d6-bbbd-4864-983b-e468a5a1a71c')
      expect(import_request.code).to eq(code)
    end
  end

  describe '#to_uri' do
    it 'returns the uri' do
      expect(import_request.to_uri).to eq(uri)
    end
  end
end
