class ReworkCompilationReleases01 < ActiveRecord::Migration[5.0]
  def change
    execute <<-DDL
      ALTER TABLE compilation_releases DROP COLUMN version;
      ALTER TABLE compilation_releases ADD COLUMN version citext;

      -- this index is accidently unique
      DROP INDEX index_compilation_releases_on_compilation_head_id;
      CREATE INDEX ON compilation_releases (compilation_head_id);
    DDL
  end
end
