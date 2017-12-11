RSpec.shared_examples 'a new reference' do
  let(:example_uri) { 'ftp://does/not/exist.example.con' }

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

  describe '#to_*' do
    subject { described_class.from_code(code) }

    it { is_expected.to respond_to(:to_code).with(0).arguments }
    it { is_expected.to respond_to(:to_key).with(0).arguments }
    it { is_expected.to respond_to(:to_uri).with(0).arguments }
  end

  describe '#eql?' do
    subject { described_class.from_code(code) }

    it { is_expected.to respond_to('eql?').with(1).argument }
  end
end


RSpec.shared_examples  'a reference initialized from_code' do
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

  describe '#to_key' do
    it 'returns the key' do
      expect(reference.to_key).to eq(key)
    end
  end

  describe '#to_uri' do
    it 'returns the uri' do
      expect(reference.to_uri).to eq(uri)
    end
  end
end

RSpec.shared_examples 'a reference initialized from_key' do
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

  describe '#to_key' do
    it 'returns the key' do
      expect(reference.to_key).to eq(key)
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

RSpec.shared_examples 'a reference initialized from_uri' do
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

  describe '#to_key' do
    it 'returns the key' do
      expect(reference.to_key).to eq(key)
    end
  end

  describe '#to_uri' do
    it 'returns the uri' do
      expect(reference.to_uri).to eq(uri)
    end
  end
end

RSpec.shared_examples 'a hash key' do
  context 'initialized with a code' do
    let(:reference) { described_class.from_code(code) }

    describe 'compared with an object initialized from_key' do
      it 'is equal' do
        expect(reference.eql?(described_class.from_key(key))).to be true
      end
    end

    describe 'compared with an object initialized from_uri' do
      it 'is equal' do
        expect(reference.eql?(described_class.from_uri(uri))).to be true
      end
    end

    describe '#hash' do
      it 'returns the uri hash' do
        expect(reference.hash).to eq(uri.hash)
      end
    end
  end

  context 'initialized with a key' do
    let(:reference) { described_class.from_key(key) }

    describe 'compared with an object initialized from_uri' do
      it 'is equal' do
        expect(reference.eql?(described_class.from_uri(uri))).to be true
      end
    end

    describe '#hash' do
      it 'returns the uri hash' do
        expect(reference.hash).to eq(uri.hash)
      end
    end
  end

  context 'initialized with an uri' do
    let(:reference) { described_class.from_uri(uri) }

    describe '#hash' do
      it 'returns the uri hash' do
        expect(reference.hash).to eq(uri.hash)
      end
    end
  end
end
