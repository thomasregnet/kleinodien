# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_singletons'
RSpec.describe BrainzImportInterrupter do
  it_behaves_like 'a singleton'

  describe '#signal_error' do
    let(:interrupter) { described_class.instance }

    before { interrupter.signal_success }

    it 'increases the errors_count by 1' do
      interrupter.signal_error
      expect(interrupter.errors_count).to eq(1)
    end
  end

  describe '#signal_success' do
    let(:interrupter) { described_class.instance }

    before { interrupter.signal_error }

    it 'resets the errors_count to 0' do
      interrupter.signal_success
      expect(interrupter.errors_count).to eq(0)
    end
  end

  describe '#multiplier' do
    let(:interrupter) { described_class.instance }

    context 'without errors' do
      before { interrupter.signal_success }

      it 'returns 1' do
        expect(interrupter.multiplier).to eq(1)
      end
    end

    context 'with 3 errors' do
      before do
        interrupter.signal_success
        3.times { interrupter.signal_error }
      end

      it 'returns 1' do
        expect(interrupter.multiplier).to eq(4)
      end
    end

    context 'with 100 errors' do
      before do
        interrupter.signal_success
        100.times { interrupter.signal_error }
      end

      it 'returns the maximal multiplier' do
        expect(interrupter.multiplier).to eq(interrupter.max_multiplier)
      end
    end
  end
end
