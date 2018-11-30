# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

# rubocop:disable Metrics/BlockLength
RSpec.describe CalculateNapMultiplier do
  context 'without an error' do
    it 'returns 1' do
      expect(described_class.call(last_multiplier: 500)).to eq(1)
    end
  end

  context 'with an error' do
    context 'when the max multiplier is not reached' do
      it 'returns the last multiplier + 1' do
        expect(described_class.call(error: true, last_multiplier: 1))
          .to eq(2)
      end
    end

    context 'when the maximal allowed multiplier is reached' do
      last_multiplier = described_class::DEFAULT_MAX_MULTIPLIER
      args = { error: true, last_multiplier: last_multiplier }
      it 'returns the maximal multiplier' do
        expect(described_class.call(args))
          .to eq(described_class::DEFAULT_MAX_MULTIPLIER)
      end
    end

    context 'when the maximal allowed multiplier is exeeded' do
      last_multiplier = described_class::DEFAULT_MAX_MULTIPLIER + 1
      args = { error: true, last_multiplier: last_multiplier }
      it 'returns the maximal multiplier' do
        expect(described_class.call(args))
          .to eq(described_class::DEFAULT_MAX_MULTIPLIER)
      end
    end
  end

  context 'without last_multiplier' do
    context 'without an error' do
      it 'raises an ArgumentError' do
        expect { described_class.call({}) }
          .to raise_error(ArgumentError, /missing last_multiplier/)
      end
    end

    context 'with an error' do
      it 'raises an ArgumentError' do
        expect { described_class.call(error: true) }
          .to raise_error(ArgumentError, /missing last_multiplier/)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
