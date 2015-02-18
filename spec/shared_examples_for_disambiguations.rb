
RSpec.shared_examples "a model with disambiguations" do
  before(:each) do
    @model = FactoryGirl.create(factory)
  end

  let(:get_name) { naming }
  let(:set_name) { naming + '=' }
  let(:disambiguation) { 'another one' }
  
  it "is not valid without a naming" do
    @model.send set_name, nil
    expect(@model).not_to be_valid
    expect { @model.save! validate: false }.to raise_error
  end

  it "must have a unique naming" do
    clone = FactoryGirl.build(factory)
    clone.send set_name, @model.send(get_name)
    expect(clone).not_to be_valid
    expect { clone.save! validate: false }.to raise_error(
                                                ActiveRecord::RecordNotUnique)
  end

  it "must have a case insensitive unique naming" do
    clone = FactoryGirl.build(factory)
    clone.send(set_name, @model.send(get_name).upcase)
    expect(clone).not_to be_valid
    expect { clone.save! validate: false }.to raise_error(
                                                ActiveRecord::RecordNotUnique)
  end

  it "is unique with a disambiguation" do
    clone = FactoryGirl.build(factory)
    clone.send(set_name, @model.send(get_name))
    clone.disambiguation = disambiguation
    expect(clone).to be_valid
    expect { clone.save! }.not_to raise_error 
  end

  it "fails if a name-disambiguation pair already exists" do
    @model.disambiguation = disambiguation
    @model.save!
    clone = FactoryGirl.build(factory)
    clone.send(set_name, @model.send(get_name))
    clone.disambiguation = disambiguation
    expect { clone.save! validate: false }.to raise_error(
                                ActiveRecord::RecordNotUnique)
  end  
end
