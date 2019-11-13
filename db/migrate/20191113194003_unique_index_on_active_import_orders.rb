class UniqueIndexOnActiveImportOrders < ActiveRecord::Migration[6.0]
  def change
    execute <<~DDL
      CREATE UNIQUE INDEX index_unique_active_import_orders
      ON import_orders (code, type)
      WHERE state in ('pending', 'preparing', 'persisting');
    DDL
  end
end
