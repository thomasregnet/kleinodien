require 'rails_helper'

RSpec.describe ArtistIdentifier, type: :model do
  before(:each) do
    @identifier = FactoryGirl.build(:artist_identifier)
  end

  it 'is valid with valid parameters' do
    expect(@identifier).to be_valid
  end

  it 'is not valid without a value' do
    @identifier.value = nil
    expect(@identifier).not_to be_valid
  end

  it 'is not valid without an artist' do
    @identifier.artist = nil
    expect(@identifier).not_to be_valid
  end

  it 'is not valid with a blank value' do
    @identifier.value = ''
    expect(@identifier).not_to be_valid
  end

  it 'is not valid without a source' do
    @identifier.source = nil
    expect(@identifier).not_to be_valid
  end
end
