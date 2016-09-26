RSpec.shared_examples 'an object with a source' do
  before(:each) do
    @object = FactoryGirl.create(factory)
  end

  it 'is valid' do
    expect(@object).to be_valid
  end

  describe 'source_name and source_ident are unique' do
    before(:each) do
      @bad_object = FactoryGirl.build(factory)
      @bad_object.source_name  = @object.source_name
      @bad_object.source_ident = @object.source_ident
    end

    it 'is not valid' do
      expect(@bad_object).not_to be_valid
    end

    it 'raises an exception if it is saved without validation' do
      expect { @bad_object.save! validate: false }
        .to raise_error ActiveRecord::RecordNotUnique
    end
  end
end
