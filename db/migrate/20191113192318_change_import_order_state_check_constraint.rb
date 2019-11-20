class ChangeImportOrderStateCheckConstraint < ActiveRecord::Migration[6.0]
  def change
    execute <<~DDL
      ALTER TABLE import_orders DROP CONSTRAINT import_orders_state_check;

      ALTER TABLE import_orders ADD CHECK
        (state IN ('pending', 'preparing', 'persisting', 'done', 'failed'));
    DDL
  end
end
