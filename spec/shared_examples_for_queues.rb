# froze_string_literal: true

RSpec.shared_examples 'a queue' do
  subject { queue }

  it { is_expected.to respond_to(:deq).with(0).arguments }
  it { is_expected.to respond_to(:enq).with(1).argument }
  it { is_expected.to respond_to('empty?').with(0).arguments }
  it { is_expected.to respond_to(:peek).with(0).arguments }

  context 'when nothing is queued' do
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

    describe '#peek' do
      it 'returns an equal object' do
        expect(queue.peek).to eq(object)
      end
    end
  end
end
