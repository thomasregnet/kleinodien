RSpec.shared_examples "an entity with credits" do

  describe "with the mininum of attributes" do
    before(:each) do
      @credit = FactoryGirl.create(factory)
    end

    it "is valid" do
      expect(@credit).to be_valid
    end
  end

  describe "with a role" do
    before(:each) do
      @credit = FactoryGirl.create(factory_with_role)
    end

    it "is valid" do
      expect(@credit).to be_valid
    end
  end

  describe "with a job" do
    before(:each) do
      @credit = FactoryGirl.create(factory_with_job)
    end

    it "is valid" do
      expect(@credit).to be_valid
    end
  end

  describe "without an owner" do
    before(:each) do
      @credit = FactoryGirl.create(factory_with_job)
      @credit.send(owner_setter, nil)
    end

    it "is not valid" do
      expect(@credit).not_to be_valid
      expect { @credit.save! validate: false }
        .to raise_error(/ERROR:\s+null value in column.+_id/)
    end
  end

  describe "without a artist_credit" do
    before(:each) do
      @credit = FactoryGirl.create(factory_with_job)
      @credit.artist_credit = nil
    end

    it "is not valid" do
      expect(@credit).not_to be_valid
      expect { @credit.save! validate: false }
        .to raise_error(/ERROR:\s+null value in column "artist_credit_id"/)
    end
  end
    
end
