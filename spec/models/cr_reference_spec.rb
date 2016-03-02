require 'rails_helper'
require 'shared_examples_for_references'

RSpec.describe CrReference, type: :model do
  it_behaves_like 'a reference' do
    let(:class_name) { CrReference }
  end
  # describe '.create_with_supplier_name!' do
  #   before(:all) do
  #     DatabaseCleaner.start
  #     @foreign_id    = 'abc-123'
  #     @supplier_name = 'DataSupplier'
  #     @reference     = CrReference.create_with_supplier_name!(
  #       @foreign_id,
  #       @supplier_name
  #     )
  #   end

  #   specify '#identifier' do
  #     expect(@reference.identifier).to eq @foreign_id
  #   end

  #   specify '#supplier' do
  #     expect(@reference.supplier.name).to eq @supplier_name
  #   end

  #   after(:all) { DatabaseCleaner.clean }
  # end
end
