RSpec.shared_examples "a label" do
  it "is valid with valid attributes " do
    expect(label).to be_valid
  end

  it "is not valid without a company" do
    label.company = nil
    expect(label).not_to be_valid
  end
    
  it "is not valid" do
    label.send(owner_setter, nil)
    expect(label).not_to be_valid
  end

  describe "with a catalog_no" do
    it "is valid" do
      expect(label_with_catalog_no).to be_valid
    end

    it "has the catalog_no set" do
      expect(label_with_catalog_no.catalog_no).not_to be_nil
    end
  end
end
