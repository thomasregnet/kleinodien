require 'rails_helper'
require 'fake_reference'
require 'ko_test_data'

RSpec.describe Importer::Store do
  let(:knowledge) { described_class.new }

  context 'without parameters' do
    describe '#having' do
      it 'returns a Hash' do
        expect(knowledge.having).to be_instance_of(Hash)
      end

      specify 'the returned hash is empty' do
        expect(knowledge.having).to be_empty
      end
    end

    describe '#missing' do
      it 'returns a Hash' do
        expect(knowledge.missing).to be_instance_of(Set)
      end

      specify 'the returned hash is empty' do
        expect(knowledge.missing).to be_empty
      end
    end

    describe '#missing?' do
      it 'returns false' do
        expect(knowledge).not_to be_missing
      end
    end
  end

  context 'request something unknown' do
    before do
      @reference = FakeReference.from_code('abc')
      @store     = described_class.new
      @store.request(@reference)
    end

    describe '#request_raw' do
      it 'returns nil' do
        expect(@store.request_raw(@reference)).to be nil
      end
    end
    describe '#request!' do
      it 'raises an error' do
        expect { @store.request!(@reference) }
          .to raise_error(Importer::KnowledgeMissing)
      end
    end
    describe '#having' do
      it 'is empty' do
        expect(@store.having).to be_empty
      end
    end

    describe '#missing' do
      it 'includes the reference' do
        expect(@store.missing).to include(@reference)
      end
    end

    describe '#missing?' do
      it 'returns true' do
        expect(@store).to be_missing
      end
    end
  end

  context 'request something known' do
    before do
      @reference = FakeReference.from_code('xyz')
      @store = described_class.new(
        having: { @reference => 'foo' }
      )
    end

    describe '#request_raw' do
      it 'returns the raw data' do
        expect(@store.request_raw(@reference)).to eq('foo')
      end
    end
    describe '#missing' do
      it 'is empty' do
        expect(@store.missing).to be_empty
      end
    end
  end
end
