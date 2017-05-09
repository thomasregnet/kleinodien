class IndexCompilationIdentifiersOnCode < ActiveRecord::Migration[4.2]
  def change
    reversible do |idx|
      idx.up do
        execute <<-DDL
          CREATE UNIQUE INDEX index_compilation_identifiers_on_code
            ON compilation_identifiers
              (compilation_release_id, identifier_type_id, code)
                WHERE disambiguation IS NULL;
        DDL
      end
      idx.down do
        remove_index(:compilation_identifiers,
                     name: :index_compilation_identifiers_on_code)
      end
    end
  end
end
