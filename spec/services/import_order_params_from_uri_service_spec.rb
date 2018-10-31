require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe ImportOrderParamsFromUriService do
  it_behaves_like 'a service'

  context 'with a valid uri' do
    let(:params) do
      described_class.call(URI('https://test.example.com/some-kind/123'))
    end

    it 'sets the right code' do
      expect(params[:code]).to eq '123'
    end

    it 'sets the right kind' do
      expect(params[:kind]).to eq 'some-kind'
    end
  end

  context 'with an uri with no path elements' do
    let(:params) do
      described_class.call(URI('https://test.example.com'))
    end

    it 'returns nil' do
      expect(params).to be nil
    end
  end

  context 'with an uri with only one path elements' do
    let(:params) do
      described_class.call(URI('https://test.example.com/some-kind'))
    end

    it 'returns nil' do
      expect(params).to be nil
    end
  end
end
