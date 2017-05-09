class RenameDataSourcesToDataSuppliers < ActiveRecord::Migration[4.2]
  def change
    rename_table :data_sources, :data_suppliers
  end
end
