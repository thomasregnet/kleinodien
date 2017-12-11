RSpec.shared_examples 'a new reference' do
  describe 'constructors' do
    subject { described_class }

    it { is_expected.to respond_to(:from_code).with(1).argument }
    it { is_expected.to respond_to(:from_key).with(1).argument }
    it { is_expected.to respond_to(:from_uri).with(1).argument }
  end

  describe 'accesors' do
    subject { described_class.from_code(code) }

    it { is_expected.to respond_to(:code).with(0).arguments }
    it { is_expected.to respond_to(:key).with(0).arguments }
    it { is_expected.to respond_to(:uri).with(0).arguments }
  end

  context 'with :code set' do
    let(:reference) { described_class.from_code(code) }

    describe '#code' do
      it 'returns the code' do
        expect(reference.code).to eq(code)
      end
    end

    describe '#key' do
      it 'returns nil' do
        expect(reference.key).to be_nil
      end
    end

    describe '#uri' do
      it 'returns nil' do
        expect(reference.uri).to be_nil
      end
    end

    describe '#to_code' do
      it 'returns the code' do
        expect(reference.to_code).to eq(code)
      end
    end

    describe '#to_uri' do
      it 'returns the uri' do
        expect(reference.to_uri).to eq(uri)
      end
    end
  end

  context 'with :key set' do
    let(:reference) { described_class.from_key(key) }

    describe '#code' do
      it 'returns nil' do
        expect(reference.code).to be_nil
      end
    end

    describe '#key' do
      it 'returns the key' do
        expect(reference.key).to eq(key)
      end
    end

    describe '#uri' do
      it 'returns nil' do
        expect(reference.uri).to be_nil
      end
    end

    describe '#to_code' do
      it 'returns the code' do
        expect(reference.to_code).to eq(code)
      end
    end
  end

  context 'with :uri set' do
    let(:reference) { described_class.from_uri(uri) }

    describe '#code' do
      it 'returns nil' do
        expect(reference.code).to be_nil
      end
    end

    describe '#key' do
      it 'returns nil' do
        expect(reference.key).to be_nil
      end
    end

    describe '#uri' do
      it 'returns the uri' do
        expect(reference.uri).to eq(uri)
      end
    end

    describe '#to_code' do
      it 'returns the code' do
        expect(reference.to_code).to eq(code)
      end
    end
  end
end
