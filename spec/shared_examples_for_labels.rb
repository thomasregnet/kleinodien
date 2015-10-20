RSpec.shared_examples "a label" do
  before(:each) do
    @label = FactoryGirl.create(factory)
  end

  describe "with valid attributes" do
    it "is valid" do
      expect(@label).to be_valid
    end
  end

  describe "without a company" do
    before(:each) do
      @label.company = nil
    end
    
    it "is not valid" do
      expect(@label).not_to be_valid
    end
  end

  describe "without an owner" do
    before(:each) do
      @label.send(owner_setter, nil)
    end
    
    it "is not valid" do
      expect(@label).not_to be_valid
    end
  end

  describe "with a catalog_no" do
    before(:each) do
      @label = FactoryGirl.create(with_catalog_no_factory)
    end

    it "is valid" do
      expect(@label).to be_valid
    end

    it "has the catalog_no set" do
      expect(@label.catalog_no).not_to be_nil
    end
  end
end
