require 'fake_reference'

class FakeKnowledgeStore < Import::KnowledgeStore
end

RSpec.shared_examples 'a knowledge field' do
  let(:reference) { FakeReference.new(code: '123') }

  context 'without knowledge' do
    context 'when nothing was requested' do
      let(:knowledge) { described_class.new(transformer: proc {}) }

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

      describe '#missing?' do
        it 'retuns false' do
          expect(knowledge.missing?).to be false
        end
      end
    end

    context 'when something was requested' do
      before(:each) do
        @knowledge = described_class.new
        @knowledge.about(reference)
      end

      describe '#about' do
        it 'retuns nil' do
          expect(@knowledge.about(reference)).to be nil
        end
      end

      describe '#about!' do
        it 'raises an exception' do
          expect { @knowledge.about!(reference) }
            .to raise_error(Import::KnowledgeMissing)
        end
      end

      describe '#missing?' do
        it 'retuns true' do
          expect(@knowledge.missing?).to be true
        end
      end
    end
  end
end
