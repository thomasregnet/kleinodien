require 'rails_helper'

RSpec.describe IncompleteDate, type: :model do
  context 'with a date-object' do
    before(:each) do
      @idate = IncompleteDate.new(Date.new(2015, 3, 16))
    end

    it 'returns the date-object' do
      expect(@idate.date).to be_instance_of(Date)
    end

    it 'returns 7 as mask' do
      expect(@idate.mask).to eq(7)
    end
  end

  context 'with a number' do
    before(:each) do
      @idate = IncompleteDate.new(2015)
    end

    it 'returns a date object' do
      expect(@idate.date).to be_instance_of(Date)
    end

    it 'returns 4 as mask' do
      expect(@idate.mask).to eq(4)
    end

    it 'has set month and day to 1' do
      expect(@idate.date.month).to eq(1)
      expect(@idate.date.day).to eq(1)
    end
  end

  context 'with a complete date-string' do
    before(:each) do
      @idate = IncompleteDate.new('2015-03-16')
    end

    it 'returns a date-object' do
      expect(@idate.date).to be_instance_of(Date)
    end

    it 'returns 7 as mask' do
      expect(@idate.mask).to eq(7)
    end
  end

  context 'with a incomplete date-string' do
    context 'with year and month' do
      before(:each) do
        @idate = IncompleteDate.new('2015-03')
      end

      it 'returns a date-object' do
        expect(@idate.date).to be_instance_of(Date)
      end

      it 'returns 6 as mask' do
        expect(@idate.mask).to eq(6)
      end

      it 'has set the day to 1' do
        expect(@idate.date.day).to eq(1)
      end
    end

    context 'with year only' do
      before(:each) do
        @idate = IncompleteDate.new('2015')
      end

      it 'returns a date-object' do
        expect(@idate.date).to be_instance_of(Date)
      end

      it 'returns 4 as mask' do
        expect(@idate.mask).to eq(4)
      end

      it 'has set month and day to 1' do
        expect(@idate.date.month).to eq(1)
        expect(@idate.date.day).to eq(1)
      end
    end
  end
end
