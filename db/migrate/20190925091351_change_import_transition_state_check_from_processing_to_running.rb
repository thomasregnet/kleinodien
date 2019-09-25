class ChangeImportTransitionStateCheckFromProcessingToRunning < ActiveRecord::Migration[6.0]
  def change
    execute <<~DDL
      ALTER TABLE import_orders DROP CONSTRAINT "import_order_state_check";
      ALTER TABLE import_requests DROP CONSTRAINT "import_order_state_check";

      ALTER TABLE import_orders ADD CONSTRAINT "import_orders_state_check"
      CHECK (
        state = ANY(
          ARRAY['pending'::text, 'running'::text, 'done'::text, 'failed'::text]
        )
      );

      ALTER TABLE import_requests ADD CONSTRAINT "import_orders_state_check"
      CHECK (
        state = ANY(
          ARRAY['pending'::text, 'running'::text, 'done'::text, 'failed'::text]
        )
      );
    DDL
  end
end
