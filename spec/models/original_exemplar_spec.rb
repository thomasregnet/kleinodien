require 'rails_helper'

RSpec.describe OriginalExemplar, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"

  before(:each) do
    @original = FactoryGirl.build(:original_exemplar)
  end

  it 'is valid with valid parameters' do
    expect(@original).to be_valid
  end

  it 'is not valid without a compilation_release' do
    @original.compilation_release = nil
    expect(@original).not_to be_valid
  end

  it 'is not valid without a user' do
    @original.user = nil
    expect(@original).not_to be_valid
  end

  it 'is not valid without a disambiguation' do
    @original.disambiguation = nil
    expect(@original).not_to be_valid
  end
end
