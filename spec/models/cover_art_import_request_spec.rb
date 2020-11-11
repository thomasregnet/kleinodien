# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CoverArtImportRequest, type: :model do
  describe '#to_uri' do
    let(:import_request) { FactoryBot.build(:cover_art_import_request, code: code) }
    let(:code) { '76122ab8-2023-11eb-a9f0-08606e75dc17' }

    it 'returns the expected uri' do
      allow(import_request).to receive(:kind).and_return('some-kind')
      expect(import_request.to_uri).to eq("https://coverartarchive.org/some-kind/#{code}")
    end

    context 'when the class does not define #kind' do
      it 'raises a NoMethodError' do
        expect { import_request.to_uri }.to raise_error(NoMethodError)
      end
    end
  end
end
