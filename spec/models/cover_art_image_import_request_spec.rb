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

  context 'without a code' do
    let(:import_request) do
      FactoryBot.build(
        :cover_art_image_import_request,
        uri: 'http://coverartarchive.org/release/58e6a3d6-bbbd-4864-983b-e468a5a1a71c/1232339678.jpg'
      )
    end

    it 'extracts the code from the uri' do
      import_request.code = nil
      import_request.valid?
      expect(import_request.code).to eq('58e6a3d6-bbbd-4864-983b-e468a5a1a71c')
    end
  end
end
