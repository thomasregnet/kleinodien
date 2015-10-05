require 'rails_helper'

RSpec.describe CrCredit, type: :model do

  describe "with the mininum of attributes" do
    before(:each) do
      @cr_credit = FactoryGirl.create(:cr_credit)
    end

    it "is valid" do
      expect(@cr_credit).to be_valid
    end
  end

  describe "with a role" do
    before(:each) do
      @cr_credit = FactoryGirl.create(:cr_credit_with_role)
    end

    it "is valid" do
      expect(@cr_credit).to be_valid
    end
  end

  describe "with a job" do
    before(:each) do
      @cr_credit = FactoryGirl.create(:cr_credit_with_job)
    end

    it "is valid" do
      expect(@cr_credit).to be_valid
    end
  end
end
