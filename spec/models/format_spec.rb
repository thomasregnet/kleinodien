require 'rails_helper'

RSpec.describe Format, type: :model do
  before(:each) do
    @format = FactoryGirl.create(:format)
  end

  it "is valid with valid attributes" do
    expect(@format).to be_valid
  end

  it "is not valid without a name" do
    @format.name = nil
    expect(@format).not_to be_valid
  end

  it "must have a unique name" do
    clone = Format.new(name: @format.name)
    expect(clone).not_to be_valid
    expect { clone.save! validate: false }.to raise_error(
                                                ActiveRecord::RecordNotUnique)
  end

  it "must have a case insensitive unique name" do
    clone = Format.new(name: @format.name.upcase)
    expect(clone).not_to be_valid
    expect { clone.save! validate: false }.to raise_error(
                                                ActiveRecord::RecordNotUnique)
  end
end
