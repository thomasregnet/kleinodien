require 'rails_helper'
require 'fake_reference'

RSpec.describe Import::KnowledgeStore do
  let(:reference) { FakeReference.new(code: '5432') }

  context 'wihout knowledge' do
    describe '#fetch' do
      it 'returns nil' do
        store = Import::KnowledgeStore.new(
          raw: {},
          transformer: proc { |value| value }
        )

        expect(store.fetch(reference)).to be nil
      end
    end
  end

  context 'with knowledge' do
    describe '#fetch' do
      it 'returns always the same knowledge' do
        store = Import::KnowledgeStore.new(
          raw: { reference.to_key => 'item' },
          transformer: proc { |value| "transformed #{value}" }
        )

        expect(store.fetch(reference)).to eq('transformed item')
        # make sure that we get always the same object
        expect(store.fetch(reference)).to equal(store.fetch(reference))
      end
    end
  end
end
