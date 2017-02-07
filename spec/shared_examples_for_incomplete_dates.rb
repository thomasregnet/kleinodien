RSpec.shared_examples "a model with an IncompleteDate" do
  let(:date_getter) { date_naming }
  let(:date_setter) { date_naming + '=' }
  
  before(:each) do
    @object = FactoryGirl.create(factory)
  end

  it "works with a Fixnum as IncompleteDate" do
    @object.send(date_setter, IncompleteDate.from_string('2015'))
    expect(@object.send(date_getter).to_s).to eq '2015-01-01'
    expect(@object.send(date_getter).mask).to eq(4)
    expect(@object.save).to be true
  end

  it "works with a String representing only year and month" do
    @object.send(date_setter, IncompleteDate.from_string('2015-03'))
    expect(@object.send(date_getter).to_s).to eq('2015-03-01')
    expect(@object.send(date_getter).mask).to eq(6)
    expect(@object.save).to be true
  end

  it "works with a String representing a iso-date" do
    @object.send(date_setter, IncompleteDate.from_string('2015-03-13'))
    expect(@object.send(date_getter).to_s).to eq('2015-03-13')
    expect(@object.send(date_getter).mask).to eq(7)
    expect(@object.save).to be true
  end
end
