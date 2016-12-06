class NewFormats < ActiveRecord::Migration[5.0]
  def change
    execute <<-DDL
      DROP TABLE formats CASCADE;

      CREATE TABLE formats (
        abbr text PRIMARY KEY,
        name text NOT NULL
      );
    DDL
  end
end
