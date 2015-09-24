RSpec.shared_examples "an entity with an unique name" do
  context "with valid attributes" do
    before(:each) do
      @entity = FactoryGirl.create(factory)
    end

    it "is valid" do
      expect(@entity).to be_valid
    end
  end

  context "without a name" do
    before(:each) do
      @entity = FactoryGirl.create(factory)
      @entity.name = nil
    end

    it "is not valid" do
      expect(@entity).not_to be_valid
      expect { @entity.save! validate: false }
        .to raise_error(/null value in column "name" violates not-null/)
    end
  end

  context "with a blank value as name" do
    before(:each) do
      @entity = Company.new(name: "")
    end

    it "is not valid" do
      expect(@entity).not_to be_valid
    end
  end

  context "name must be unique" do
    before(:each) do
      @entity  = FactoryGirl.create(factory)

      @clone   = FactoryGirl.build(factory)
      @clone.name = @entity.name

      @uc_clone = FactoryGirl.build(factory)
      @uc_clone.name = @entity.name
    end

    it "is not valid whith the a duplicate name" do
      expect(@clone).not_to be_valid
      expect(@uc_clone).not_to be_valid

      expect {@clone.save! validate: false }
        .to raise_error(
              /duplicate key value violates unique constraint/)

      expect {@uc_clone.save! validate: false }
        .to raise_error(
              /duplicate key value violates unique constraint/)
    end
  end
end
