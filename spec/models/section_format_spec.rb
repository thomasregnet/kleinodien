require 'rails_helper'

RSpec.describe SectionFormat, type: :model do
  before(:each) do
    @format = FactoryGirl.create(:section_format)
  end

  it 'is valid with valid attributes' do
    expect(@format).to be_valid
  end

  it 'is not valid without a name' do
    @format.name = nil
    expect(@format).not_to be_valid
    expect { @format.save! validate: false }.to raise_error(
      ActiveRecord::StatementInvalid)
  end

  it 'is not valid withaut an abbr' do
    @format.abbr = nil
    expect(@format).not_to be_valid
    expect { @format.save! validate: false }.to raise_error(
      ActiveRecord::StatementInvalid)
  end
end
