require 'rails_helper'

RSpec.describe Repository, type: :model do
  before(:each) do
    @repository = FactoryGirl.build(:repository)
  end

  it 'is valid with valid attributes' do
    expect(@repository).to be_valid
  end

  it 'is not valid without a name' do
    @repository.name = nil
    expect(@repository).not_to be_valid
  end

  it 'is not valid without a user' do
    @repository.user = nil
    expect(@repository).not_to be_valid
  end
end
