class CreateIndexOnCompilationHeadsSourceNameAndSourceIdent < ActiveRecord::Migration[5.0]
  def change
    reversible do |idx|
      idx.up do
        execute <<-DDL.gsub /^\s+/, ''
          CREATE UNIQUE INDEX "index_compilation_heads_sorce_name_sorce_ident"
            ON "compilation_heads" (source_name, source_ident)
              WHERE "source_ident" IS NOT NULL;
        DDL
      end
      idx.down do
        remove_index :compilation_heads,
                     name: :index_compilation_heads_sorce_name_sorce_ident
      end
    end
  end
end
