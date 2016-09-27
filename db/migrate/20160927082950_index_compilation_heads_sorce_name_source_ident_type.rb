class IndexCompilationHeadsSorceNameSourceIdentType < ActiveRecord::Migration[5.0]
  def change
    remove_index :compilation_heads,
                 name: :index_compilation_heads_sorce_name_sorce_ident

    execute <<-DDL.gsub /^\s+/, ''
      CREATE UNIQUE INDEX "index_compilation_heads_sorce_name_sorce_ident_type"
        ON "compilation_heads" (source_name, source_ident, type)
          WHERE "source_ident" IS NOT NULL;
    DDL
  end
end
