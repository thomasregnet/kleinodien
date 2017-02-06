class CitextForArtistsNameAndDisambiguation < ActiveRecord::Migration[5.0]
  def change
    execute <<-DDL
      -- drop columns
      ALTER TABLE artists DROP COLUMN name;
      ALTER TABLE artists DROP COLUMN disambiguation;

      -- add column name and set it NOT NULL
      ALTER TABLE artists ADD COLUMN name citext;
      ALTER TABLE artists ALTER COLUMN name SET NOT NULL;

      -- add column "disambiguation" as citext
      ALTER TABLE artists ADD COLUMN disambiguation citext;
    DDL
  end
end
