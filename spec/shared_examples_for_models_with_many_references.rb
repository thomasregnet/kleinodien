RSpec.shared_examples 'a model with many References' do
  before(:each) do
    @model = FactoryGirl.create(factory)
  end

  it 'responds to "references"' do
    expect(@model).to respond_to(:references)
    expect(@model.references.length).to be >= 1
  end
end
