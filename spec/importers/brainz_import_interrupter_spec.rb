# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_singletons'

# rubocop:disable Metrics/BlockLength
RSpec.describe BrainzImportInterrupter do
  it_behaves_like 'a singleton'

  describe '#perform' do
    let(:interrupter) { described_class.instance }

    it 'returns nil' do
      expect(interrupter.perform).to be_nil
    end
  end

  describe '#interruption' do
    context 'without errors' do
      let(:interrupter) { described_class.instance }

      before { interrupter.signal_success }

      it 'returns 1' do
        expect(interrupter.interruption).to eq(1)
      end
    end
  end

  describe '#min_interruption' do
    it 'returns 1' do
      expect(described_class.instance.min_interruption).to eq(1)
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

      it 'returns 4' do
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

  describe '#time_to_sleep' do
    context 'without errors and a "last" far in the past' do
      let(:interrupter) { described_class.instance }
      let(:last) { Time.new(1970) }
      let(:now) { Time.new(2019) }

      before do
        interrupter.signal_success
        allow(interrupter).to receive(:last).and_return(last)
        allow(interrupter).to receive(:now).and_return(now)
      end

      it 'returns 0' do
        expect(interrupter.time_to_sleep).to eq(0)
      end
    end

    context 'without errors and  "last" == "now"' do
      let(:interrupter) { described_class.instance }
      let(:time) { Time.now }

      before do
        3.times { interrupter.signal_error }
        allow(interrupter).to receive(:last).and_return(time)
        allow(interrupter).to receive(:now).and_return(time)
      end

      after { interrupter.signal_success }

      it 'returns the correct interruption time' do
        expect(interrupter.time_to_sleep).to eq(4)
      end
    end

    context 'without errors and "last" == "now"' do
      let(:interrupter) { described_class.instance }
      let(:time) { Time.now }

      before do
        interrupter.signal_success
        allow(interrupter).to receive(:last).and_return(time)
        allow(interrupter).to receive(:now).and_return(time)
      end

      it 'returns 0' do
        expect(interrupter.time_to_sleep).to eq(1)
      end
    end

    context 'with errors and "last" == "now"' do
      let(:interrupter) { described_class.instance }
      let(:time) { Time.now }

      before do
        3.times { interrupter.signal_error }
        allow(interrupter).to receive(:last).and_return(time)
        allow(interrupter).to receive(:now).and_return(time)
      end

      after { interrupter.signal_success }

      it 'returns the correct interruption time' do
        expect(interrupter.time_to_sleep).to eq(4)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
