class RenameDataSourcesToDataSuppliers < ActiveRecord::Migration
  def change
    rename_table :data_sources, :data_suppliers
  end
end
