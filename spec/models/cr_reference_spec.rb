require 'rails_helper'

RSpec.describe CrReference, type: :model do
  describe '.create_with_supplier_name!' do
    before(:all) do
      DatabaseCleaner.start
      @foreign_id    = 'abc-123'
      @supplier_name = 'DataSupplier'
      @reference     = CrReference.create_with_supplier_name!(
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

    after(:all) { DatabaseCleaner.clean }
  end
end
