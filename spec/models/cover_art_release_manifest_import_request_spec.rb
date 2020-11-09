# frozen_string_literal: true

require 'rails_helper'

require 'shared_examples_for_code_uuid_validations'
require 'shared_examples_for_import_requests'

RSpec.describe CoverArtReleaseManifestImportRequest, type: :model do
  include_examples 'for ImportRequests', :cover_art_release_manifest_import_request
  include_examples(
    'for code fields that must be an uuid',
    :cover_art_release_manifest_import_request
  )

  def uuid
    @uuid ||= SecureRandom.uuid.to_s
  end

  describe '#to_uri' do
    let(:code) { '0fb17dd8-2027-11eb-a791-08606e75dc17' }
    let(:import_request) { FactoryBot.build(:cover_art_release_manifest_import_request, code: code) }

    it 'returns the uri' do
      expect(import_request.to_uri).to eq("https://coverartarchive.org/release/#{code}")
    end
  end
end
