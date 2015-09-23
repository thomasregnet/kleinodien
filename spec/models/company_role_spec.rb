require 'rails_helper'

RSpec.describe CompanyRole, type: :model do
  before(:each) do
    @company_role = FactoryGirl.create(:company_role)
  end

  context "with a name set" do
    it "is valid" do
      expect(@company_role).to be_valid
    end
  end

  context "with no name set" do
    before(:each) do
      @company_role = CompanyRole.new
    end

    it "is not valid" do
      expect(@company_role).not_to be_valid
    end
  end

  context "with name set to a blank value" do
    before(:each) do
      @company_role = CompanyRole.new(name: "")
    end

    it "is not valid" do
      expect(@company_role).not_to be_valid
    end
  end

  context "two entities with the same name" do
    before(:each) do
      @company_role = FactoryGirl.create(:company_role)
      @clone_role   = FactoryGirl.build(:company_role)
      @clone_role.name = @company_role.name
    end

    it "is not valid when the name already exists" do
      expect(@clone_role).not_to be_valid
      expect{ @clone_role.save! validate: false }
        .to raise_error(/duplicate.+ violates.+"index_company_roles_on_name"/)
    end
  end
  
end
