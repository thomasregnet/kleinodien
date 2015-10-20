RSpec.shared_examples "a company" do
  describe "with valid attributes" do
    before(:each) do
      @company = FactoryGirl.create(factory)
    end

    it "is valid" do
      expect(@company).to be_valid
    end
  end

  describe "without a company" do
    before(:each) do
      @company = FactoryGirl.create(factory)
      @company.company = nil
    end

    it "is not valid" do
      expect(@company).not_to be_valid
      expect { @company.save! validate: false }
        .to raise_error(/null value.+_id.+not-null constraint/)
    end
  end

  describe "without a company_role" do
    before(:each) do
      @company = FactoryGirl.create(factory)
      @company.company_role = nil
    end

    it "is not valid" do
      expect(@company).not_to be_valid
      expect { @company.save! validate: false }
        .to raise_error(/null value.+_id.+not-null constraint/)
    end
  end

  describe "without a owner" do
    before(:each) do
      @company = FactoryGirl.create(factory)
      @company.send(owner_setter, nil) 
    end

    it "is not valid" do
      expect(@company).not_to be_valid
      expect { @company.save! validate: false }
        .to raise_error(/null value.+id.+not-null/)
    end
  end

end
