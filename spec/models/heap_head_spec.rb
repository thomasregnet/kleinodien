# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HeapHead, type: :model do
  it { is_expected.to belong_to(:artist_credit).without_validating_presence }
  it { is_expected.to belong_to(:import_order).without_validating_presence }

  describe '#title' do
    let(:head) { FactoryBot.build(:heap_head) }

    context 'when nil' do
      it 'is not valid' do
        head.title = nil
        expect(head).not_to be_valid
      end
    end

    context 'when nil' do
      it 'is not valid' do
        head.title = ''
        expect(head).not_to be_valid
      end
    end
  end
end
