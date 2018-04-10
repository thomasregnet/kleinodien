# froze_string_literal: true

RSpec.shared_examples 'a queue' do
  subject { queue }

  it { is_expected.to respond_to(:clear).with(0).arguments }
  it { is_expected.to respond_to(:deq).with(0).arguments }
  it { is_expected.to respond_to(:enq).with(1).argument }
  it { is_expected.to respond_to('empty?').with(0).arguments }
  it { is_expected.to respond_to(:length).with(0).arguments }
  it { is_expected.to respond_to(:peek).with(0).arguments }

  context 'when nothing is queued' do
    describe '#clear' do
      it 'returns 0' do
        expect(queue.clear).to eq(0)
      end
    end

    describe '#deq' do
      it 'returns nil' do
        expect(queue.deq).to be_nil
      end
    end

    describe '#empty?' do
      it 'returns true' do
        expect(queue).to be_empty
      end
    end

    describe '#length' do
      it 'returns 0' do
        expect(queue.length).to eq(0)
      end
    end

    describe '#peek' do
      it 'returns nil' do
        expect(queue.peek).to be_nil
      end
    end
  end

  context 'when an object is queued' do
    before do
      queue.enq(object)
    end

    describe '#clear' do
      it 'returns 1' do
        expect(queue.clear).to eq(1)
      end
    end

    describe '#deq' do
      it 'returns an equal object' do
        expect(queue.deq).to eq(object)
      end
    end

    describe '#empty?' do
      it 'returns false' do
        expect(queue).not_to be_empty
      end
    end

    describe '#length' do
      it 'returns 1' do
        expect(queue.length).to eq(1)
      end
    end

    describe '#peek' do
      it 'returns an equal object' do
        expect(queue.peek).to eq(object)
      end
    end
  end
end
