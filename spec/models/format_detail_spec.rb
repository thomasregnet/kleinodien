require 'rails_helper'

RSpec.describe FormatDetail, type: :model do
  before(:each) do
    @format_detail = FactoryGirl.build(:format_detail)
  end

  it 'is valid with valid parameters' do
    expect(@format_detail).to be_valid
  end

  it 'is not valid without a abbr' do
    @format_detail.abbr = nil
    expect(@format_detail).not_to be_valid
  end

  it 'is not valid without a name' do
    @format_detail.name = nil
    expect(@format_detail).not_to be_valid
  end    
end
