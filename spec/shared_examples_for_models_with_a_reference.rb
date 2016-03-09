RSpec.shared_examples 'a model with a Reference' do
  before(:each) do
    @model = FactoryGirl.create(factory)
  end

  it 'responds to "reference"' do
    expect(@model).to respond_to('reference')
  end

  specify '#find_by_reference' do
    #byebug
    #from_reference = @model.class.find_by_reference(
    from_reference = @model.class.find_by_reference(
      @model.reference.identifier,
      @model.reference.supplier.name
    )
    #byebug
    expect(from_reference).to be_instance_of @model.class
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
