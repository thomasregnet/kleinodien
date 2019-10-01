class DropNotNullConstraintOnImportOrdersType < ActiveRecord::Migration[6.0]
  def change
    execute <<~DDL
      ALTER TABLE import_orders ALTER COLUMN type DROP NOT NULL;
    DDL
  end
end
