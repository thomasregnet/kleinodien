require 'rails_helper'

RSpec.describe Country, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  context "with valid values" do
    before(:each) do
      @country = FactoryGirl.create(:country)
    end

    it "is valid" do
      expect(@country).to be_valid
    end
  end
end
