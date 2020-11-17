# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe CoverArtFetcher do
  it_behaves_like 'a service'

  describe '.call' do
    let(:attempt) { ImportRequestAttempt }
    let(:faraday_connection) { instance_double('Faraday::Connection')}
    let(:fetcher) { described_class.new(import_request: import_request) }
    let(:import_request) { FactoryBot.create(:cover_art_release_manifest_import_request) }
    let(:response) { instance_double 'Faraday::Response' }

    before do
      allow(import_request).to receive(:to_uri).and_return('https://example.com/foo/bar')
    end

    context 'when there is someting to fetch' do
      before do
        allow(fetcher).to receive(:faraday_connection).and_return(faraday_connection)
        allow(faraday_connection).to receive(:get).and_return(response)
        allow(import_request).to receive(:attempts).and_return(attempt)
        allow(attempt).to receive(:create!)
        allow(response).to receive(:reason_phrase)
        allow(response).to receive(:status)
        allow(response).to receive(:success?).and_return(true)
      end

      it 'returns a Faraday response body' do
        expect(fetcher.call).to eq(response)
      end
    end

    context 'when there is nothing to fetch' do
      before do
        allow(fetcher).to receive(:max_tries).and_return(1)
        allow(fetcher).to receive(:faraday_connection).and_return(faraday_connection)
        allow(faraday_connection).to receive(:get).and_return(response)
        allow(import_request).to receive(:attempts).and_return(attempt)
        allow(attempt).to receive(:create!)
        allow(response).to receive(:reason_phrase)
        allow(response).to receive(:status)
        allow(response).to receive(:success?).and_return(false)
      end

      it 'raises an ImportError::CanNotFetch' do
        expect { fetcher.call }.to raise_error ImportError::CanNotFetch
      end
    end
  end
end
