require 'fake_reference'

RSpec.shared_examples 'knowledge about' do 
  let(:reference) { FakeReference.new(code: '123') }

  context 'without knowledge' do
    let(:knowledge) { described_class.new() }

    describe '#about' do
      it 'returns nil' do
        expect(knowledge.about(reference)).to be_nil
      end
    end

    describe '#about!' do
      it 'raises an exception' do
        expect { knowledge.about!(reference) }
          .to raise_error(Import::KnowledgeMissing)
      end
    end
  end
end
