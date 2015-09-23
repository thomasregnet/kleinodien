require 'rails_helper'

RSpec.describe CrCompany, type: :model do

  describe "with valid attributes" do
    before(:each) do
      @cr_company = FactoryGirl.create(:cr_company)
    end

    it "is valid" do
      expect(@cr_company).to be_valid
    end
  end
      
end
