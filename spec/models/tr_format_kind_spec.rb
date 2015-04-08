require 'rails_helper'

RSpec.describe TrFormatKind, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  before(:each) do
    @trfk = FactoryGirl.create(:tr_format_kind)
  end

  it "is valid with valid attributes" do
    expect(@trfk).to be_valid
  end
end
