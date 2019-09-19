# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
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
      let(:import_queue) { FactoryBot.build(:import_queue) }

      before { import_queue.name = '' }

      it 'is not valid' do
        expect(import_queue).not_to be_valid
      end
    end

    context 'with forbidden characters' do
      let(:messages) do
        iq = ImportQueue.new(name: 'FooBar')
        iq.valid?
        iq.errors.messages
      end

      it 'contains the correct error-message' do
        expect(messages[:name].first)
          .to eq('allows only lower case letters, digits and the underscore')
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
