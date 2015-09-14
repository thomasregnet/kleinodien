RSpec.shared_examples "a format kind" do
  before(:each) do
    @format_kind = FactoryGirl.create(factory)
  end

  it "is valid with valid attributes" do
    expect(@format_kind).to be_valid
  end

  it "is not valid without a name" do
    @format_kind.name = ''
    expect(@format_kind).not_to be_valid
    
    @format_kind.name = nil
    expect(@format_kind).not_to be_valid
  end

  it "must have a unique name" do
    clone = FactoryGirl.create(factory)
    clone.name = @format_kind.name
    expect(clone).not_to be_valid

    clone = FactoryGirl.create(factory)    
    clone.name = @format_kind.name.upcase
    expect(clone).not_to be_valid
    expect { clone.save! validate: false }.to raise_error do |error|
      expect(error).to be_a(ActiveRecord::RecordNotUnique)
    end
  end
end  
