# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_pieces'

RSpec.describe Song, type: :model do
  it { is_expected.to belong_to(:artist_credit).required(false) }

  it 'is valid with valid attributes' do
    expect(FactoryBot.build(:song)).to be_valid
  end

  it_behaves_like 'a piece' do
    let(:piece) { FactoryBot.build(:song) }
  end
end
