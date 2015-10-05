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

  describe "without a compilation_release" do
    before(:each) do
      @cr_credit = FactoryGirl.create(:cr_credit_with_job)
      @cr_credit.compilation_release = nil
    end

    it "is not valid" do
      expect(@cr_credit).not_to be_valid
      expect { @cr_credit.save! validate: false }
        .to raise_error(/ERROR:\s+null value in column.+_id/)
    end
  end

  describe "without a artist_credit" do
    before(:each) do
      @cr_credit = FactoryGirl.create(:cr_credit_with_job)
      @cr_credit.artist_credit = nil
    end

    it "is not valid" do
      expect(@cr_credit).not_to be_valid
      expect { @cr_credit.save! validate: false }
        .to raise_error(/ERROR:\s+null value in column "artist_credit_id"/)
    end
  end
    
end
