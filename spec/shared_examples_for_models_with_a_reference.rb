RSpec.shared_examples 'a model with a Reference' do
  before(:each) do
    @model = FactoryGirl.create(factory)
  end

  it 'responds to "reference"' do
    expect(@model).to respond_to('reference')
  end

  describe 'reference_id must be unique' do
    before(:each) do
      @other_model = FactoryGirl.create(factory)
      @other_model.reference = @model.reference
    end

    it 'is not valid' do
      expect(@other_model).not_to be_valid
      expect { @other_model.save! validate: false }
        .to raise_error(/ERROR:\s+duplicate key.+violates unique constraint/)
    end
  end
end
