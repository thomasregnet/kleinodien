class ReneamSourceIdentifierDataSourceIdToDataSupplierId < ActiveRecord::Migration[4.2]
  def change
    rename_column :source_identifiers, :data_source_id, :data_supplier_id
  end
end
