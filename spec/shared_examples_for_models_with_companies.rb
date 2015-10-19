RSpec.shared_examples "a model with companies" do
  before(:each) do
      @model = FactoryGirl.create(factory)
  end
  
  it "has the companies set" do
    expect(@model.companies.length).to eq(2)
  end
end
