# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IncompleteDate, type: :model do
  describe '.from_string' do
    context 'with a complete date' do
      let(:incomplete_date) { described_class.from_string('2021-03-11') }

      it 'is valid' do
        expect(incomplete_date).to be_valid
      end

      it 'has set the correct year' do
        expect(incomplete_date.year).to eq(2021)
      end

      it 'has set the correct month' do
        expect(incomplete_date.month).to eq(3)
      end

      it 'has set the correct day' do
        expect(incomplete_date.day).to eq(11)
      end
    end

    context 'with year and month' do
      let(:incomplete_date) { described_class.from_string('2021-03') }

      it 'is valid' do
        expect(incomplete_date).to be_valid
      end

      it 'has set the correct year' do
        expect(incomplete_date.year).to eq(2021)
      end

      it 'has set the correct month' do
        expect(incomplete_date.month).to eq(3)
      end

      it 'has set the day to nil' do
        expect(incomplete_date.day).to be_nil
      end
    end

    context 'with only a year' do
      let(:incomplete_date) { described_class.from_string('2021') }

      it 'is valid' do
        expect(incomplete_date).to be_valid
      end

      it 'has set the correct year' do
        expect(incomplete_date.year).to eq(2021)
      end

      it 'has set the month to nil' do
        expect(incomplete_date.month).to be_nil
      end

      it 'has set the day to nil' do
        expect(incomplete_date.day).to be_nil
      end
    end

    context 'with an invalid string' do
      let(:incomplete_date) { described_class.from_string('2021-13-44') }

      it 'is not valid' do
        expect(incomplete_date).not_to be_valid
      end

      it 'has set the year to nil' do
        expect(incomplete_date.year).to be_nil
      end
    end
  end

  describe '.new' do
    context 'with valid values' do
      let(:incomplete_date) { described_class.new(2021, 3, 11) }

      it 'is valid' do
        expect(incomplete_date).to be_valid
      end
    end

    context 'without any values' do
      let(:incomplete_date) { described_class.new(nil, nil, nil) }

      it 'is valid' do
        expect(incomplete_date).to be_valid
      end
    end

    context 'with wrong values' do
      it 'is not valid' do
        expect(described_class.new('Bad', 'value')).not_to be_valid
      end
    end
  end

  describe '#accuracy' do
    context 'with complete date' do
      it 'returns :day' do
        expect(described_class.new(2021, 3, 11).accuracy).to eq(:day)
      end
    end

    context 'with year and month' do
      it 'returns :month' do
        expect(described_class.new(2021, 3).accuracy).to eq(:month)
      end
    end

    context 'with year only' do
      it 'returns :year' do
        expect(described_class.new(2021).accuracy).to eq(:year)
      end
    end

    context 'without values' do
      it 'returns nil' do
        expect(described_class.new.accuracy).to be_nil
      end
    end
  end

  describe '#any?' do
    context 'with a year' do
      it 'returns true' do
        expect(described_class.new(2021)).to be_any
      end
    end

    context 'with year and month' do
      it 'returns true' do
        expect(described_class.new(2021, 3)).to be_any
      end
    end

    context 'with year, month and day' do
      it 'returns true' do
        expect(described_class.new(2021, 3, 11)).to be_any
      end
    end

    context 'without any values' do
      it 'returns true' do
        expect(described_class.new).not_to be_any
      end
    end

    context 'with invalid values' do
      it 'returns true' do
        expect(described_class.new('Zeke', 'evil', :dead)).not_to be_any
      end
    end
  end

  describe '#to_s' do
    context 'with a complete date' do
      it 'returns the right date-string' do
        expect(described_class.new(2019, 3, 2).to_s).to eq('2019-03-02')
      end
    end

    context 'with year and month' do
      let(:incomplete_date) do
        described_class.new(2019, 3)
      end

      it 'returns the right date-string' do
        expect(described_class.new(2019, 3).to_s).to eq('2019-03')
      end
    end

    context 'with year only' do
      it 'returns the right date-string' do
        expect(described_class.new(2019).to_s).to eq('2019')
      end
    end

    context 'without any values' do
      it 'returns nil' do
        expect(described_class.new.to_s).to be_nil
      end
    end
  end

  describe '<=>' do
    context 'when accuracies differ' do
      it 'compares the smallest common dominator' do
        incomplete_date_1 = described_class.new(2021, 3, 11)
        incomplete_date_2 = described_class.new(2021)

        expect(incomplete_date_1 == incomplete_date_2).to be_truthy
      end
    end

    context 'with equal accuracies' do
      it 'compares full dates (YYYY-mm-dd)' do
        expect(described_class.new(2021, 3, 11) > described_class.new(2021, 3, 10)).to be_truthy
      end

      it 'compares YYYY-mm' do
        expect(described_class.new(2021, 2) < described_class.new(2021, 3)).to be_truthy
      end

      it 'compares YYYY' do
        expect(described_class.new(2021) > described_class.new(2020)).to be_truthy
      end
    end

    context 'when one date is nil' do
      it 'raises an exception' do
        expect { described_class.new(2021, 3) < described_class.new }
          .to raise_error(ArgumentError, /comparison of IncompleteDate with IncompleteDate failed/)
      end
    end
  end

  describe '#year_month_day' do
    context 'with a full date' do
      it 'returns an array with that date' do
        expect(described_class.new(2021, 3, 11).year_month_day).to eq([2021, 3, 11])
      end
    end

    context 'when only the year is set' do
      it 'returns an array with the year and two nil values' do
        expect(described_class.new(2021).year_month_day).to eq([2021, nil, nil])
      end
    end
  end
end
