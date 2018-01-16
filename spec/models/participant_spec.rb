require 'rails_helper'

RSpec.describe Participant, type: :model do
  before(:each) do
    @participant = Participant.new(
      artist:        FactoryBot.create(:artist),
      artist_credit: FactoryBot.create(:artist_credit),
      position:      0
    )
  end

  it 'is valid with valid attributes' do
    expect(@participant).to be_valid
  end

  it 'is not valid without a artist' do
    @participant.artist = nil
    expect(@participant).not_to be_valid
  end

  it 'is not valid without a artist_credit' do
    @participant.artist_credit = nil
    expect(@participant).not_to be_valid
  end

  it 'is not valid without a position' do
    @participant.position = nil
    expect(@participant).not_to be_valid
  end
end
