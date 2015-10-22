RSpec.shared_examples 'a model with a SourceIdentifier' do
  before(:each) do
    @model = FactoryGirl.create(factory)
  end

  it 'responds to "source_identifier"' do
    expect(@model).to respond_to('source_identifier')
  end
end
