class AddUniqueIndexesOnImportOrdersCodeWherePendingOrProcessing < ActiveRecord::Migration[5.2]
  def change
    reversible do |idx|
      idx.up do
        execute <<-DDL
          CREATE UNIQUE INDEX index_unique_import_orders_pending_or_processing
          ON "import_orders" (code, kind, type)
          WHERE state = 'pending' OR state = 'processing';
        DDL
      end
      idx.down do
        execute <<-DDL.gsub(/^\s+/, '')
          DROP INDEX index_unique_import_orders_pending_or_processing
        DDL
      end
    end
  end
end
