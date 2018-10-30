# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe BrainzImportOrderParamsFromUriService do
  it_behaves_like 'a service'

  def code
    '1cfffb1a-7dfe-4875-856d-bdffe4a2ea9e'
  end

  def kind
    'release'
  end

  context 'with a html uri' do
    let(:params) do
      prefix = 'https://musicbrainz.org'
      uri_string = [prefix, kind, code].join('/')
      described_class.call(URI(uri_string))
    end

    it 'returns the right code' do
      expect(params[:code]).to eq code
    end

    it 'returns the right kind' do
      expect(params[:kind]).to eq kind
    end
  end

  context 'with a ws/2 uri' do
    let(:params) do
      prefix = 'https://musicbrainz.org/ws/2'
      uri_string = [prefix, kind, code].join('/')
      described_class.call(URI(uri_string))
    end

    it 'returns the right code' do
      expect(params[:code]).to eq code
    end

    it 'returns the right kind' do
      expect(params[:kind]).to eq kind
    end
  end
end
