# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

# Just for test
class AnalyzeImportOrderUriServiceBase
  def type
    'SomeImportOrderType'
  end
end

# rubocop:disable Metrics/BlockLength
RSpec.describe AnalyzeImportOrderUriServiceBase do
  it_behaves_like 'a service'

  context 'with a valid uri' do
    let(:params) do
      described_class.call(
        uri_obj: URI('https://test.example.com/some-kind/123')
      )
    end

    it 'sets the right code' do
      expect(params[:code]).to eq '123'
    end

    it 'sets the right kind' do
      expect(params[:kind]).to eq 'some-kind'
    end

    it 'sets the expected type' do
      expect(params[:type]).to eq 'SomeImportOrderType'
    end
  end

  context 'with an uri with no path elements' do
    let(:params) do
      described_class.call(uri_obj: URI('https://test.example.com'))
    end

    it 'returns nil' do
      expect(params).to be nil
    end
  end

  context 'with an uri with only one path elements' do
    let(:params) do
      described_class.call(uri_obj: URI('https://test.example.com/some-kind'))
    end

    it 'returns nil' do
      expect(params).to be nil
    end
  end
end
# rubocop:enable Metrics/BlockLength
