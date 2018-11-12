# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_import_requests'

RSpec.describe BrainzReleaseImportRequest, type: :model do
  include_examples 'for ImportRequests', :brainz_release_import_request

  def uuid
    @uuid ||= SecureRandom.uuid.to_s
  end

  describe '#to_uri' do
    let(:import_request) do
      FactoryBot.build(
        :brainz_release_import_request,
        code: uuid
      )
    end

    let(:uri) do
      'https://musicbrainz.org/ws/2/release/' \
        + uuid \
        + 'inc=artists+labels+recordings+release-groups'
    end

    it 'returns the uri' do
      expect(import_request.to_uri).to eq(uri)
    end
  end
end
