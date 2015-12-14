require 'rails_helper'

RSpec.describe Duration, type: :model do
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

  describe 'constructor "milliseconds"' do
    before(:all) do
      @duration = Duration.new(999_987_123)
    end

    it 'has the expected values set' do
      expect(@duration.milliseconds).to eq(999_987_123)
      expect(@duration.accuracy).to eq('millisecond')
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
      expect(@duration.accuracy).to eq('hour')
    end
  end

  describe 'constructor "mmss"' do
    before(:all) do
      @duration = Duration.mmss('3:11')
    end

    it 'has the expected values set' do
      expect(@duration.milliseconds).to eq(191_000)
      expect(@duration.accuracy).to eq('second')
    end
  end

  describe 'constructor "mmss"' do
    before(:all) do
      @duration = Duration.hhmm('4:56')
    end

    it 'has the expected values set' do
      expect(@duration.milliseconds).to eq(17760000)
      expect(@duration.accuracy).to eq('minute')
    end
  end

  describe 'constructor "hhmmss"' do
    before(:all) do
      @duration = Duration.hhmmss('19:44:13')
    end

    it 'has the expected values set' do
      expect(@duration.milliseconds).to eq(71053000)
      expect(@duration.accuracy).to eq('second')
    end
  end

  describe 'conversions' do
    context 'even' do
      before(:all) do
        @duration = Duration.milliseconds(6_330_000) # 1:45:30
      end

      it 'returns the correct conversions' do
        expect(@duration.accuracy).to eq('millisecond')

        expect(@duration.hours).to eq(1)
        expect(@duration.minutes).to eq(105)
        expect(@duration.seconds).to eq(6_330)

        expect(@duration.minutes_left).to eq(45)
        expect(@duration.seconds_left_rounded).to eq(30)

        expect(@duration.mmss).to eq('105:30')
        expect(@duration.hhmmss).to eq('1:45:30')
      end
    end

    context 'round up' do
      before(:all) do
        @duration = Duration.milliseconds(6_330_500) # 1:45:31
      end

      it 'returns the correct conversions' do
        expect(@duration.seconds).to eq(6_330)
        expect(@duration.seconds_left_rounded).to eq(31)
        expect(@duration.mmss).to eq('105:31')
        expect(@duration.hhmmss).to eq('1:45:31')
      end
    end

    context 'round down' do
      before(:all) do
        @duration = Duration.milliseconds(6_329_400) # 1:45:29
      end

      it 'returns the correct conversions' do
        expect(@duration.seconds).to eq(6_329)
        expect(@duration.seconds_left_rounded).to eq(29)
        expect(@duration.mmss).to eq('105:29')
        expect(@duration.hhmmss).to eq('1:45:29')
      end
    end
  end
end
