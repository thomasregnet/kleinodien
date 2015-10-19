RSpec.shared_examples "a model with countries" do
  before(:each) do
    @model = FactoryGirl.create(factory)
  end

  it "has two countries set" do
    expect(@model.countries.length).to eq(2)
  end
end
