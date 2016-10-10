require 'rails_helper'

RSpec.describe RepositoryPosition, type: :model do
  before(:each) do
    @position = FactoryGirl.create(:repository_position_with_compilation_track)
  end

  it 'is valid' do
    expect(@position).to be_valid
  end

  it 'is not valid without an user' do
    @position.user = nil
    expect(@position).not_to be_valid
  end
end
