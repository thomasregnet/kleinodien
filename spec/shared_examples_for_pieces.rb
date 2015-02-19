RSpec.shared_examples "a piece" do
  before(:each) do
    @piece = FactoryGirl.create(factory)
  end

  it "is not valid without head" do
    @piece.head = nil
    expect(@piece).not_to be_valid
  end
end
