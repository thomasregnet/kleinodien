require 'fake_reference'

RSpec.shared_examples 'knowledge field' do 
  let(:reference) { FakeReference.new(code: '123') }

  context 'without knowledge' do
    let(:knowledge) { described_class.new }

    describe '#field' do
      it 'returns nil' do
        expect(knowledge.about(reference)).to be_nil
      end
    end

    describe '#field!' do
      it 'raises an exception' do
        expect { knowledge.about!(reference) }
          .to raise_error(Import::KnowledgeMissing)
      end
    end
  end

  context 'with knowledge' do
    let(:knowledge) { described_class.new }

    before(:each) do
      @item = { this_is: 'known' }
      @knowledge = described_class.new
      @knowledge.known[reference.to_key] = @item
    end

    describe '#field' do
      it 'returns the knowledge' do
        expect(@knowledge.about(reference)).to eq(@item)
      end
    end

    describe '#field!' do
      it 'returns the knowledge' do
        expect(@knowledge.about!(reference)).to eq(@item)
      end
    end
  end
end
