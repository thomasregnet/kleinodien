require 'rails_helper'
require 'fake_reference'
require 'ko_test_data'

RSpec.describe Import::Store do
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

  context 'ask_for something unknown' do
    before do
      @reference = FakeReference.from_code("abc")
      @knowledge = described_class.new
      @knowledge.ask_for(@reference)
    end

    describe '#ask_for_raw' do
      it 'returns nil' do
        expect(@knowledge.ask_for_raw(@reference)).to be nil
      end
    end
    describe '#ask_for!' do
      it 'raises an error' do
        expect { @knowledge.ask_for!(@reference) }
          .to raise_error(Import::KnowledgeMissing)
      end
    end
    describe '#having' do
      it 'is empty' do
        expect(@knowledge.having).to be_empty
      end
    end

    describe '#missing' do
      it 'includes the reference' do
        expect(@knowledge.missing).to include(@reference)
      end
    end

    describe '#missing?' do
      it 'returns true' do
        expect(@knowledge).to be_missing
      end
    end
  end

  context 'ask_for something known' do
    before do
      @reference = FakeReference.from_code('xyz')
      @knowledge = described_class.new(
        having: { @reference => 'foo' }
      )
    end

    describe '#ask_for_raw' do
      it 'returns the raw data' do
        expect(@knowledge.ask_for_raw(@reference)).to eq('foo')
      end
    end
    describe '#missing' do
      it 'is empty' do
        expect(@knowledge.missing).to be_empty
      end
    end
  end
end
