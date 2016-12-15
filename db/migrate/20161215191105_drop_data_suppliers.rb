class DropDataSuppliers < ActiveRecord::Migration[5.0]
  def change
    execute <<-DDL
      ALTER TABLE artist_credits DROP COLUMN data_supplier_id;

      ALTER TABLE artist_credits ADD COLUMN source_name text;

      ALTER TABLE artist_credits
      ADD CONSTRAINT fk_artist_credits_sources_name
      FOREIGN KEY (source_name) REFERENCES sources (name);

      DROP TABLE data_suppliers;
    DDL
  end
end
