# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PieceRelease, type: :model do
  it { is_expected.to belong_to(:heap) }
  it { is_expected.to belong_to(:import_order) }
  it { is_expected.to belong_to(:piece) }

  context 'with valid parameters' do
    let(:piece_release) { FactoryBot.build(:piece_release) }

    it 'is valid' do
      expect(piece_release).to be_valid
    end
  end

  context 'with a heap and a position' do
    context 'without a heap' do
      let(:piece_release) { FactoryBot.build(:piece_release_with_heap) }

      it 'is valid' do
        expect(piece_release).to be_valid
      end
    end
  end

  describe '#position' do
    context 'without a heap' do
      let(:piece_release) { FactoryBot.build(:piece_release_with_heap) }

      it 'is not valid' do
        piece_release.heap = nil
        expect(piece_release).not_to be_valid
      end
    end
  end

  describe '#heap' do
    context 'without a position' do
      let(:piece_release) { FactoryBot.build(:piece_release_with_heap) }

      it 'is not valid' do
        piece_release.position = nil

        expect(piece_release).not_to be_valid
      end
    end
  end
end
