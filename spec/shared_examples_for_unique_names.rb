RSpec.shared_examples "an entity with an unique name" do
  context "with valid attributes" do
    before(:each) do
      @entity = FactoryGirl.create(factory)
    end

    it "is valid" do
      expect(@entity).to be_valid
    end
  end
end
