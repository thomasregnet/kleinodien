require 'rails_helper'

RSpec.describe CompanyRole, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
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
  
end
