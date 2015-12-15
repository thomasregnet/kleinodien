require 'rails_helper'

RSpec.shared_examples 'a duration constructor' do
  let (:duration) { @duration = Duration.send(constructor, value) }

  it 'has the milliseconds set' do
    expect(duration.milliseconds).to eq(milliseconds)
  end

  it 'has the accuracy set' do
    expect(duration.accuracy).to eq(accuracy)
  end
end

RSpec.describe Duration, type: :model do
  describe '.new' do
    context 'without accuracy' do
      duration = Duration.new(300123)

      it 'has the milliseconds set' do
        expect(duration.milliseconds).to eq(300123)
      end

      it 'has the accuracy set' do
        expect(duration.accuracy).to eq('millisecond')
      end
    end

    context 'with accuracy' do
      duration = Duration.new(123456, 'second')

      it 'uses the given accuracy' do
        expect(duration.accuracy).to eq('second')
      end
    end
  end

  describe '.hours' do
    it_behaves_like 'a duration constructor' do
      let(:constructor)  { 'hours' }
      let(:value)        { 7 }
      let(:milliseconds) { 25200000 }
      let(:accuracy)     { 'hour' }
    end
  end

  describe '.minutes' do
    it_behaves_like 'a duration constructor' do
      let(:constructor)  { 'minutes' }
      let(:value)        { 10 }
      let(:milliseconds) { 600_000 }
      let(:accuracy)     { 'minute'}
    end
  end

  describe '.seconds' do
    it_behaves_like 'a duration constructor' do
      let(:constructor)  { 'seconds' }
      let(:value)        { 322 }
      let(:milliseconds) { 322000 }
      let(:accuracy)     { 'second'}
    end
  end

  describe '.milliseconds' do
    it_behaves_like 'a duration constructor' do
      let(:constructor)  { 'milliseconds' }
      let(:value)        { 999_987_123 }
      let(:milliseconds) { 999_987_123 }
      let(:accuracy)     { 'millisecond'}
    end
  end

  describe '.mmss' do
    it_behaves_like 'a duration constructor' do
      let(:constructor)  { 'mmss' }
      let(:value)        { '3:11' }
      let(:milliseconds) { 191_000 }
      let(:accuracy)     { 'second'}
    end
  end

  describe '.hhmm' do
    it_behaves_like 'a duration constructor' do
      let(:constructor)  { 'hhmm' }
      let(:value)        { '4:56' }
      let(:milliseconds) { 17_760_000 }
      let(:accuracy)     { 'minute'}
    end
  end

  describe '.hhmmss' do
    it_behaves_like 'a duration constructor' do
      let(:constructor)  { 'hhmmss' }
      let(:value)        { '19:44:13' }
      let(:milliseconds) { 71_053_000 }
      let(:accuracy)     { 'second'}
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
