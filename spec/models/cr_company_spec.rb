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

  describe "without a company" do
    before(:each) do
      @cr_company = FactoryGirl.create(:cr_company)
      @cr_company.company = nil
    end

    it "is not valid" do
      expect(@cr_company).not_to be_valid
      expect { @cr_company.save! validate: false }
        .to raise_error(/null value.+"company_id".+not-null constraint/)
    end
  end

    describe "without a company_role" do
    before(:each) do
      @cr_company = FactoryGirl.create(:cr_company)
      @cr_company.company_role = nil
    end

    it "is not valid" do
      expect(@cr_company).not_to be_valid
      expect { @cr_company.save! validate: false }
        .to raise_error(/null value.+"company_role_id".+not-null constraint/)
    end
  end
    
end
