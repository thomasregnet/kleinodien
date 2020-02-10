# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe IncompleteDate, type: :model do
  describe '.new' do
    let(:incomplete_date) do
      described_class.new(Date.new(2015, 12, 13), 7)
    end

    specify '#date' do
      expect(incomplete_date.date).to be_instance_of Date
    end

    specify '#mask' do
      expect(incomplete_date.mask).to eq 7
    end
  end

  describe '.from_string' do
    context 'with a complete date' do
      let(:incomplete_date) do
        described_class.from_string('2015-12-13')
      end

      it 'returns 7 when it receives #mask' do
        expect(incomplete_date.mask).to eq 7
      end

      it 'returns the year' do
        expect(incomplete_date.year).to eq(2015)
      end

      it 'returns the month' do
        expect(incomplete_date.month).to eq(12)
      end

      it 'returns the dey' do
        expect(incomplete_date.day).to eq(13)
      end
    end

    context 'with year and month' do
      let(:incomplete_date) do
        described_class.from_string('2015-12')
      end

      it 'returns 7 when it receives #mask' do
        expect(incomplete_date.mask).to eq 6
      end

      it 'returns the year' do
        expect(incomplete_date.year).to eq(2015)
      end

      it 'returns the month' do
        expect(incomplete_date.month).to eq(12)
      end

      it 'returns 1 for the dey' do
        expect(incomplete_date.day).to eq(1)
      end
    end

    context 'with year only' do
      let(:incomplete_date) do
        described_class.from_string('2015')
      end

      it 'returns 7 when it receives #mask' do
        expect(incomplete_date.mask).to eq 4
      end

      it 'returns the year' do
        expect(incomplete_date.year).to eq(2015)
      end

      it 'returns 1 for the month' do
        expect(incomplete_date.month).to eq(1)
      end

      it 'returns 1 for the dey' do
        expect(incomplete_date.day).to eq(1)
      end
    end
  end

  describe '#to_s' do
    context 'with a complete date' do
      let(:incomplete_date) do
        described_class.new(Date.new(2019, 3, 2), 7)
      end

      it 'returns the right date-string' do
        expect(incomplete_date.to_s).to eq('2019-03-02')
      end
    end

    context 'with year and month' do
      let(:incomplete_date) do
        described_class.new(Date.new(2019, 3, 2), 6)
      end

      it 'returns the right date-string' do
        expect(incomplete_date.to_s).to eq('2019-03')
      end
    end

    context 'with year only' do
      let(:incomplete_date) do
        described_class.new(Date.new(2019, 3, 2), 4)
      end

      it 'returns the right date-string' do
        expect(incomplete_date.to_s).to eq('2019')
      end
    end
  end

  context 'with an invalid mask' do
    describe '#to_s' do
      let(:incomplete_date) { described_class.new(Date.new(2019, 3, 2), 7) }

      it 'raises a RuntimeError' do
        allow(incomplete_date).to receive(:mask).and_return(:wtf)
        expect { incomplete_date.to_s }
          .to raise_error(RuntimeError, /invalid mask/)
      end
    end

    describe '.new' do
      it 'raises an ArgumentError' do
        expect { described_class.new(Date.new(2019, 3, 2), :wrong) }
          .to raise_error(ArgumentError, /invalid mask/)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
