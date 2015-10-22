RSpec.shared_examples 'a model with a SourceIdentifier' do
  before(:each) do
    @model = FactoryGirl.create(factory)
  end

  it 'responds to "source_identifier"' do
    expect(@model).to respond_to('source_identifier')
  end

  describe 'source_identifier_id must be unique' do
    before(:each) do
      @other_model = FactoryGirl.create(factory)
      @other_model.source_identifier = @model.source_identifier
    end

    it 'is not valid' do
      expect(@other_model).not_to be_valid
    end
  end
end
