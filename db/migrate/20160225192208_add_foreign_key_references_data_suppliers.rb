class AddForeignKeyReferencesDataSuppliers < ActiveRecord::Migration[4.2]
  def change
    add_foreign_key :references, :data_suppliers
  end
end
