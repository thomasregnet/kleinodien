class FkRepositoryPositionsCompilationCopies < ActiveRecord::Migration[5.0]
  def change
    reversible do |fk|
      fk.up do
        execute <<-DDL.gsub /^\s+/, ''
          -- we need an unique index on "compilation_copies" to reference it
          CREATE UNIQUE INDEX index_compilation_copies
          ON compilation_copies (id, compilation_release_id, user_id);

          ALTER TABLE repository_positions
          ADD COLUMN compilation_copy_id integer;

          ALTER TABLE repository_positions
          ADD CONSTRAINT fk_repository_positions_compilation_copies
          FOREIGN KEY (compilation_copy_id, compilation_release_id, user_id)
          REFERENCES compilation_copies (id, compilation_release_id, user_id);
        DDL
      end
      fk.down do
        execute <<-DDL.gsub /^\s+/, ''
          ALTER TABLE repository_positions
          DROP CONSTRAINT fk_repository_positions_compilation_copies;

          DROP INDEX index_compilation_copies;

          ALTER TABLE repository_positions
          DROP COLUMN compilation_copy_id;
        DDL
      end
    end
  end
end
