require 'rails_helper'

RSpec.shared_examples 'a duration constructor' do
  let (:duration) { @duration = Duration.send(constructor, value) }

  it 'sets the milliseconds' do
    expect(duration.milliseconds).to eq(milliseconds)
  end

  it 'sets the accuracy' do
    expect(duration.accuracy).to eq(accuracy)
  end
end

RSpec.shared_examples 'a duration converting object' do
  let(:duration) { Duration.milliseconds(milliseconds) }

  specify '#hours returns the hours' do
    expect(duration.hours).to eq(hours)
  end

  specify '#minutes returns the minutes' do
    expect(duration.minutes).to eq(minutes)
  end

  specify '#seconds returns the seconds' do
    expect(duration.seconds).to eq(seconds)
  end

  specify '#mmss returns mm:ss' do
    expect(duration.mmss).to eq(mmss)
  end

  specify '#hhmm returns hh:mm' do
    expect(duration.hhmm).to eq(hhmm)
  end
  
  specify '#mmss returns hh:mm:ss' do
    expect(duration.hhmmss).to eq(hhmmss)
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

  describe '#minutes_left' do
    duration = Duration.milliseconds(4_200_000)

    it 'returns the left minutes' do
      expect(duration.minutes_left).to eq(10)
    end
  end

  describe '#minutes_left_rounded' do\
    context 'round up' do
      duration = Duration.milliseconds(90_000)

      it 'returns the rounded left minutes' do
        expect(duration.minutes_left_rounded).to eq(2)
      end
    end

    context 'round down' do
      duration = Duration.milliseconds(89_999)

      it 'returns the rounded left minutes' do
        expect(duration.minutes_left_rounded).to eq(1)
      end      
    end
  end
 
  describe '#seconds_left_rounded' do
    context 'round up' do
      duration = Duration.milliseconds(60_500)

      it 'returns the rounded left seconds' do
        expect(duration.seconds_left_rounded).to eq(1)
      end
    end

    context 'round down' do
      duration = Duration.milliseconds(60_499)

      it 'returns the rounded left seconds' do
        expect(duration.seconds_left_rounded).to eq(0)
      end
    end
  end

  describe 'conversions' do
    context 'with even seconds' do
      it_behaves_like 'a duration converting object' do
        let(:milliseconds) { 6_330_000 }
        let(:hours)        { 1 }
        let(:minutes)      { 105 }
        let(:seconds)      { 6_330 }
        let(:mmss)         { '105:30' }
        let(:hhmm)         { '1:46' }
        let(:hhmmss)       { '1:45:30' }
      end
    end

    context 'with seconds to be rouned up' do
      it_behaves_like 'a duration converting object' do
        let(:milliseconds) { 6_330_500 }
        let(:hours)        { 1 }
        let(:minutes)      { 105 }
        let(:seconds)      { 6_330 }
        let(:mmss)         { '105:31' }
        let(:hhmm)         { '1:46' }
        let(:hhmmss)       { '1:45:31' }        
      end
    end

    context 'with seconds to be rouned down' do
      it_behaves_like 'a duration converting object' do
        let(:milliseconds) { 6_329_400 }
        let(:hours)        { 1 }
        let(:minutes)      { 105 }
        let(:seconds)      { 6_329 }
        let(:mmss)         { '105:29' }
        let(:hhmm)         { '1:45' }
        let(:hhmmss)       { '1:45:29' }        
      end
    end
  end
end
