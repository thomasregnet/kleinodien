RSpec.shared_examples "a model with labels" do
  before(:each) do
    @model = FactoryGirl.create(factory)
  end

  it "has labels set" do
    expect(@model.labels.length).to eq(2)
  end
end
