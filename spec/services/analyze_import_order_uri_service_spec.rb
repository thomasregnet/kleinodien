# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

# OPTIMIZE: mock specs
# rubocop:disable Metrics/BlockLength
RSpec.describe AnalyzeImportOrderUriService do
  it_behaves_like 'a service'

  context 'with valid arguments' do
    def code
      '88c27b7d-83e3-4568-8724-fafbee54f05a'
    end

    def kind
      'release'
    end

    def uri_string
      "https://musicbrainz.org/ws/2/#{kind}/#{code}/"
    end

    describe '.call' do
      let(:result) { described_class.call(uri_string: uri_string) }

      it 'returns the expected code' do
        expect(result[:code]).to eq(code)
      end

      it 'returns the expected kind' do
        expect(result[:kind]).to eq(kind)
      end

      it 'returns the expected type' do
        expect(result[:type]).to eq('BrainzReleaseImportOrder')
      end
    end

    context 'with invalid arguments' do
      it 'returns a hash' do
        expect(described_class.call(uri_string: 'foobar'))
          .to be_nil
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
