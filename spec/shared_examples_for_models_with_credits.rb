RSpec.shared_examples "a model with credits" do

  before(:each) do
    @model = FactoryGirl.create(factory)
  end

  it "has credits set" do
    expect(@model.credits.length).to eq(2)
  end
end
