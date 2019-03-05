# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Heap, type: :model do
  it { is_expected.to belong_to(:artist_credit).without_validating_presence }
  it { is_expected.to belong_to(:head).class_name('HeapHead') }
  it { is_expected.to belong_to(:import_order).without_validating_presence }
  it { is_expected.to have_many(:media) }
  it { is_expected.to have_many(:subsets) }

  context 'with valid attributes' do
    let(:heap) { FactoryBot.build(:heap) }

    it 'is valid' do
      expect(heap).to be_valid
    end
  end

  describe '#head' do
    let(:heap) { FactoryBot.build(:heap) }

    context 'when nil' do
      it 'is not valid' do
        heap.head = nil
        expect(heap).not_to be_valid
      end
    end
  end
end
