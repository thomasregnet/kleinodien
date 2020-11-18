# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe CoverArtFetchAttempt do
  it_behaves_like 'a service'

  describe '#call' do
    let(:fetch_attempt) { described_class.new(import_request: import_request) }
    let(:import_request) { instance_double('ImportRequest') }
    let(:import_request_attempt) { class_double('ImportRequestAttempt') }
    let(:response) { instance_double('Faraday::Response') }

    before do
      allow(fetch_attempt).to receive(:response).and_return(response)
      allow(import_request).to receive(:attempts).and_return(import_request_attempt)
      allow(import_request_attempt).to receive(:create!)
      allow(response).to receive(:reason_phrase)
      allow(fetch_attempt).to receive(:url).and_return('http://example.com/test/data')
    end

    context 'when the http GET status is 200' do
      before { allow(response).to receive(:status).and_return(200) }

      it 'returns the response' do
        expect(fetch_attempt.call).to eq(response)
      end
    end

    context 'when the http GET status is 404' do
      before { allow(response).to receive(:status).and_return(404) }

      it 'returns the response' do
        expect(fetch_attempt.call).to eq(response)
      end
    end

    context 'when the http GET status is 400' do
      before { allow(response).to receive(:status).and_return(400) }

      it 'raises an ImportErcor concerning UUID' do
        expect { fetch_attempt.call }.to raise_error(ImportError::CanNotFetch, /valid UUID/)
      end
    end

    context 'when the http GET status is 405' do
      before { allow(response).to receive(:status).and_return(405) }

      it 'raises an ImportErcor concerning request method' do
        expect { fetch_attempt.call }.to raise_error(ImportError::CanNotFetch, /not one of GET or HEAD/)
      end
    end

    context 'when the http GET status is 406' do
      before { allow(response).to receive(:status).and_return(406) }

      it 'raises an ImportErcor concerning Accept header' do
        expect { fetch_attempt.call }.to raise_error(ImportError::CanNotFetch, /Accept header/)
      end
    end

    context 'when the http GET status is 503' do
      before { allow(response).to receive(:status).and_return(503) }

      it 'raises an ImportErcor concerning rate limit' do
        expect { fetch_attempt.call }.to raise_error(ImportError::CanNotFetch, /rate limit/)
      end
    end
  end
end
