require 'rails_helper'

RSpec.describe Duration, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  describe 'constructor' do
    context 'without accuracy' do
      before(:all) do
        @duration = Duration.new(300123)
      end

      it 'has the expected values set' do
        expect(@duration.milliseconds).to eq(300123)
        expect(@duration.accuracy).to eq('millisecond')
      end
    end
  end

  describe 'construtor "seconds"' do
    before(:all) do
      @duration = Duration.seconds(322)
    end

    it 'has the expected values set' do
      expect(@duration.milliseconds).to eq(322000)
      expect(@duration.accuracy).to eq('second')
    end
  end

  describe 'construtor "seconds"' do
    before(:all) do
      @duration = Duration.minutes(10)
    end

    it 'has the expected values set' do
      expect(@duration.milliseconds).to eq(600_000)
      expect(@duration.accuracy).to eq('minute')
    end
  end

  describe 'constructor "hours"' do
    before(:all) do
      @duration = Duration.hours(7)
    end

    it 'has the expected values set' do
      expect(@duration.milliseconds).to eq(25200000)
      expect(@duration.milliseconds).to eq(25200000)
      expect(@duration.accuracy).to eq('hour')
    end
  end
end
