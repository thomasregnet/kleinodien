require 'rails_helper'

RSpec.describe CrFormatDetail, type: :model do
  before(:each) do
    @cr_format_detail = FactoryGirl.build(:cr_format_detail)
  end

  it 'is valid with valid parameters' do
    expect(@cr_format_detail).to be_valid
  end

  it 'is not valid without an detail' do
    @cr_format_detail.detail = nil
    expect(@cr_format_detail).not_to be_valid
  end

  it 'is not valid without an format' do
    @cr_format_detail.format = nil
    expect(@cr_format_detail).not_to be_valid
  end

  it 'is not valid without an position' do
    @cr_format_detail.position = nil
    expect(@cr_format_detail).not_to be_valid
  end
end
