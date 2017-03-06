class CitextForSourcesName < ActiveRecord::Migration[5.0]
  def change
    execute <<-DDL
      ALTER TABLE sources DROP COLUMN name;
      ALTER TABLE sources ADD COLUMN name citext;
      ALTER TABLE sources ALTER COLUMN name SET NOT NULL;
      CREATE UNIQUE INDEX on sources (name);
    DDL
  end
end
