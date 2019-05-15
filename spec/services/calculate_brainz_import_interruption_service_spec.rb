# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

# rubocop:disable Metrics/BlockLength
RSpec.describe CalculateBrainzImportInterruptionService do
  it_behaves_like 'a service'

  describe '.call' do
    let(:args) do
      {
        last:                Time.new(1970),
        needed_interruption: 2
      }
    end

    context 'when the needed_interruption has passed' do
      before { args[:now] = Time.new(1970) + 3 }

      it 'returns 0' do
        expect(described_class.call(args)).to eq(0)
      end
    end

    context 'when the needed_interruption has not passed' do
      before { args[:now] = Time.new(1970) + 1 }

      it 'returns the expected time to interrupt' do
        expect(described_class.call(args)).to eq(1.0)
      end
    end

    context 'when the needed_interruption has exactly passed' do
      before { args[:now] = Time.new(1970) + 2 }

      it 'returns 0' do
        expect(described_class.call(args)).to eq(0)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
