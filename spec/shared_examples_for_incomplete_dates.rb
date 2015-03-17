RSpec.shared_examples "a model with an IncompleteDate" do
  before(:each) do
    @object = FactoryGirl.create(factory)
  end

  it "works with a Fixnum as IncompleteDate" do
    idate = IncompleteDate.new(2015)
    @object.date = idate
    expect(@object.date.to_s).to eq('2015-01-01')
    expect(@object.date.mask).to eq(4)
    expect(@object.save).to be true
  end

  it "works with a String representing only a year" do
    @object.date = IncompleteDate.new('2015')
    expect(@object.date.to_s).to eq('2015-01-01')
    expect(@object.date.mask).to eq(4)
    expect(@object.save).to be true
  end
  
  it "works with a String representing only year and month" do
    @object.date = IncompleteDate.new('2015-03')
    expect(@object.date.to_s).to eq('2015-03-01')
    expect(@object.date.mask).to eq(6)
    expect(@object.save).to be true
  end

  it "works with a String representing a iso-date" do
    @object.date = IncompleteDate.new('2015-03-13')
    expect(@object.date.to_s).to eq('2015-03-13')
    expect(@object.date.mask).to eq(7)
    expect(@object.save).to be true
  end
end
