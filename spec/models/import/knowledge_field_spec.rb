require 'rails_helper'
require 'fake_reference'

RSpec.describe Import::KnowledgeField do
  let(:reference) { FakeReference.new(code: 'xyz') }

  context 'with an empty store' do
    before(:each) do
      @field = Import::KnowledgeField.new(
        Import::KnowledgeStore.new(
          raw: {},
          transformer: proc { |value| value }
        )
      )
    end

    describe '#about' do
      it 'returns nil' do
        expect(@field.about(reference)).to be nil
      end
    end

    describe '#about!' do
      it 'raises an exception' do
        expect { @field.about!(reference) }
          .to raise_exception Import::KnowledgeMissing
      end
    end

    describe '#missing?' do
      it 'returns false' do
        expect(@field.missing?).to be false
      end
    end
  end
end
