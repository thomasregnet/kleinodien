# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportQueue, type: :model do
  it { should respond_to(:about) }
  it { should respond_to(:name) }

  context 'with valid parameters' do
    let(:import_queue) { FactoryBot.build(:import_queue) }

    it 'is valid' do
      expect(import_queue).to be_valid
    end
  end

  describe '#name' do
    subject { FactoryBot.create(:import_queue) }

    it { should validate_uniqueness_of(:name) }

    context 'when empty' do
      let(:import_queue) { FactoryBot.build(:import_queue) }

      before { import_queue.name = nil }

      it 'is not valid' do
        expect(import_queue).not_to be_valid
      end
    end

    context 'when blank' do
      let(:import_queue) { described_class.new(name: '') }

      it 'is not valid' do
        expect(import_queue).not_to be_valid
      end
    end

    context 'with forbidden characters' do
      let(:messages) do
        iq = described_class.new(name: 'FooBar')
        iq.valid?
        iq.errors.messages
      end

      it 'contains the correct error-message' do
        expect(messages[:name].first)
          .to eq('allows only lower case letters, digits and the underscore')
      end
    end
  end

  describe '.next_pending_for' do
    context 'with nothing queued' do
      let(:import_queue_name) { FactoryBot.create(:import_queue).name }

      it 'returns nil' do
        expect(described_class.next_pending_for(import_queue_name))
          .to be_nil
      end
    end

    context 'with import_orders queue' do
      # pending 'with import_orders'
      let(:import_queue) { FactoryBot.create(:import_queue) }
      let(:old) { DateTime.new(1971, 1, 1, 1, 1, 1) }

      before do
        # OPTIMIZE: use a generic ImportOrder, not "Brainz"
        # this is currently due to a NOT NULL constraint on
        # import_orders.type not possible
        FactoryBot.create(:brainz_import_order, import_queue: import_queue)
        FactoryBot.create(
          :brainz_import_order,
          created_at:   old,
          import_queue: import_queue
        )
      end

      it 'returns the oldest import_order' do
        expect(described_class.next_pending_for(import_queue.name).created_at)
          .to eq(old)
      end
    end

    # TODO: What todo with invalid queue names?
    context 'with invalid queue name' do
      pending 'invalid queue name'
    end
  end
end
