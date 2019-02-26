# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_pieces'

RSpec.describe Song, type: :model do
  before(:each) do
    @song = FactoryBot.create(:song)
  end

  it 'is valid with valid attributes' do
    expect(@song).to be_valid
  end

  it_behaves_like 'a piece' do
    let(:piece) { @song }
  end

  it 'belongs_to :artist_credit' do
    song = FactoryBot.create(:song)
    song.artist_credit = FactoryBot.create(:artist_credit)
    expect { song.save! }.not_to raise_error

    association = Song.reflect_on_association(:artist_credit)
    expect(association.macro).to eq(:belongs_to)
  end
end
