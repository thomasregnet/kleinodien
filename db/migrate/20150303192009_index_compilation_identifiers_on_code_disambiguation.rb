class IndexCompilationIdentifiersOnCodeDisambiguation < ActiveRecord::Migration
  def change
    reversible do |idx|
      idx.up do
        execute <<-DDL
          CREATE UNIQUE INDEX
            index_compilation_identifiers_on_code_disambiguation
              ON compilation_identifiers
                (compilation_release_id, identifier_type_id,
                 code, LOWER(disambiguation));
        DDL
      end
      idx.down do
        remove_index(
          :compilation_identifiers,
          name: :index_compilation_identifiers_on_code_disambiguation)
      end
    end
  end
end
