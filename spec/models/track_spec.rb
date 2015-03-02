require 'rails_helper'

RSpec.describe Track, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  before(:each) do
    @track = FactoryGirl.create(:track)
  end

  it "is valid with valid attributes" do
    expect(@track).to be_valid
  end
end
