# frozen_string_literal: true

require 'rails_helper'

# Provide a "kind" for testing
class TestBrainzImportRequestSomeKind < BrainzImportRequest
  def kind
    'some-kind'
  end
end

# No "kind" to let the test fail
class TestBrainzImportRequestNoKind < BrainzImportRequest
end

# Provide a query_string
class TestBrainzImportRequestWithQueryString < TestBrainzImportRequestSomeKind
  def initialize(args)
    @query_string = args.delete(:query_string)
    super(args)
  end

  attr_reader :query_string
end

RSpec.describe BrainzImportRequest, type: :model do
  def uuid
    @uuid ||= SecureRandom.uuid.to_s
  end

  def query_string
    '?inc=some-more-data'
  end

  describe '#to_uri' do
    context 'when the derived class implements #query_string' do
      let(:import_request) do
        TestBrainzImportRequestWithQueryString.new(
          code:         uuid,
          query_string: query_string
        )
      end

      let(:uri) do
        "https://musicbrainz.org/ws/2/some-kind/#{uuid}#{query_string}"
      end

      it 'returns the uri' do
        expect(import_request.to_uri).to eq(uri)
      end
    end

    context 'when the derived class does not implement #query_string' do
      let(:import_request) { TestBrainzImportRequestSomeKind.new(code: uuid) }
      let(:uri) { "https://musicbrainz.org/ws/2/some-kind/#{uuid}" }

      it 'returns the uri' do
        expect(import_request.to_uri).to eq(uri)
      end
    end

    context 'when derived class does not implement "kind"' do
      let(:import_request) do
        TestBrainzImportRequestNoKind.new(
          code: uuid
        )
      end

      it 'raises NotImplementedError' do
        expect { import_request.to_uri }.to raise_error NotImplementedError
      end
    end
  end
end
