class AddCheckConstraintToImportRequestsState < ActiveRecord::Migration[5.2]
  def change
    reversible do |constraint|
      constraint.up do
        execute <<-DDL.gsub /^\s+/, ''
          ALTER TABLE import_requests
            ADD CONSTRAINT import_order_state_check
            CHECK (state IN ('pending', 'processing', 'done', 'failed'));
        DDL
      end
      constraint.down do
        execute <<-DDL.gsub /^\s+/, ''
          ALTER TABLE import_requests
            DROP CONSTRAINT import_order_state_check;
        DDL
      end
    end
  end
end
