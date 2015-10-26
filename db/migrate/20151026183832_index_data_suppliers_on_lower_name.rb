class IndexDataSuppliersOnLowerName < ActiveRecord::Migration
  def change
   reversible do |idx|
      idx.up do
        execute <<-DDL.gsub /^\s+/, ''
          CREATE UNIQUE INDEX index_data_suppliers_on_lower_name
            ON data_suppliers (LOWER(name));
        DDL
      end
      idx.down do
        remove_index :data_suppliers, name: :index_data_suppliers_on_lower_name
      end
    end
  end
end
