RSpec.shared_examples 'a reference' do
  before(:each) do
    @foreign_id    = 'abc-123'
    @supplier_name = 'DataSupplier'
    @reference     = class_name.create_with_supplier_name!(
      @foreign_id,
      @supplier_name
    )
  end

  specify '#identifier' do
    expect(@reference.identifier).to eq @foreign_id
  end

  specify '#supplier' do
    expect(@reference.supplier.name).to eq @supplier_name
  end
end
