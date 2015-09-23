require 'rails_helper'

RSpec.describe Company, type: :model do


  context "with valid attributes" do
    before(:each) do
      @company = FactoryGirl.create(:company)
    end
    
    it "is valid" do
      expect(@company).to be_valid
    end
  end

  context "without a name" do
    before(:each) do
      @company = Company.new
    end

    it "is not valid" do
      expect(@company).not_to be_valid
      expect { @company.save! validate: false }
        .to raise_error(/null value in column "name" violates not-null/)
    end
  end

  context "with a blank value as name" do
    before(:each) do
      @company = Company.new(name: "")
    end

    it "is not valid" do
      expect(@company).not_to be_valid
    end
  end

  context "name must be unique" do
    before(:each) do
      @company  = FactoryGirl.create(:company)
      @clone    = Company.new(name: @company.name)
      @uc_clone = Company.new(name: @company.name.upcase)
    end

    it "is not valid whith the a duplicate name" do
      expect(@clone).not_to be_valid
      expect(@uc_clone).not_to be_valid

      expect {@clone.save! validate: false }
        .to raise_error(
              /duplicate.+violates.+"index_companies_on_lower_name"/)
      expect {@uc_clone.save! validate: false }
        .to raise_error(
              /duplicate.+violates.+"index_companies_on_lower_name"/)
    end
  end
end
