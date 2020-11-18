# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe CoverArtFetcher do
  it_behaves_like 'a service'

  describe '.call' do
    let(:import_request) { FactoryBot.create(:cover_art_release_manifest_import_request) }
    let(:response) { instance_double 'Faraday::Response' }

    context 'when the CoverArtFetchAttempt returns a reponse with status 200' do
      before do
        allow(response).to receive(:status).and_return(200)
        allow(CoverArtFetchAttempt).to receive(:call).and_return(response)
      end

      it 'returns a Faraday::Response' do
        expect(described_class.call(import_request: import_request)).to eq(response)
      end
    end

    context 'when there is nothing to fetch' do
      before do
        allow(response).to receive(:status).and_return(404)
        allow(CoverArtFetchAttempt).to receive(:call).and_return(response)
      end

      it 'raises an ImportError::CanNotFetch' do
        expect(described_class.call(import_request: import_request)).to be_nil
      end
    end

    context 'when the CoverArtFetchAttempt raises an error' do
      before do
        allow(CoverArtFetchAttempt).to receive(:call).and_raise(ImportError::CanNotFetch)
      end

      it 'passes that error' do
        expect { described_class.call(import_request: import_request) }
          .to raise_error(ImportError::CanNotFetch)
      end
    end
  end
end
