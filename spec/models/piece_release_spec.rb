# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PieceRelease, type: :model do
  it { is_expected.to belong_to(:import_order) }
  it { is_expected.to belong_to(:piece) }

  context 'with valid parameters' do
    let(:piece_release) { FactoryBot.build(:piece_release) }

    it 'is valid' do
      expect(piece_release).to be_valid
    end
  end
end
