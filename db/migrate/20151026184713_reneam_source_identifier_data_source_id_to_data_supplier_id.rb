class ReneamSourceIdentifierDataSourceIdToDataSupplierId < ActiveRecord::Migration
  def change
    rename_column :source_identifiers, :data_source_id, :data_supplier_id
  end
end
