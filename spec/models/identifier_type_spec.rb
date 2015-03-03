require 'rails_helper'

RSpec.describe IdentifierType, type: :model do
  before(:each) do
    @id_type = FactoryGirl.create(:identifier_type)
  end

  it "is valid with valid attributes" do
    expect(@id_type).to be_valid
  end
end
