# frozen_string_literal: true

require 'rails_helper'
require 'test_data/result_base'

RSpec.describe TestData::ResultBase do
  context 'when initialized with a string' do
    def string
      'a test string'
    end

    let(:result) { described_class.new(string) }

    describe '#raw' do
      it 'returns the given string' do
        expect(result.raw).to eq string
      end
    end

    describe '#to_s' do
      it 'returns the raw string' do
        expect(result.to_s).to eq string
      end
    end
  end
end
