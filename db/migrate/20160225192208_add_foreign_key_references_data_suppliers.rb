class AddForeignKeyReferencesDataSuppliers < ActiveRecord::Migration
  def change
    add_foreign_key :references, :data_suppliers
  end
end
