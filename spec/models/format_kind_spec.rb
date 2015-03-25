require 'rails_helper'

RSpec.describe FormatKind, type: :model do
  before(:each) do
    @fki = FactoryGirl.create(:format_kind)
  end

  it "is valid with valid attributes" do
    expect(@fki).to be_valid
  end
end
