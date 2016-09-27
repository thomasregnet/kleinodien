class IndexCompilationReleasesSorceNameSourceIdentType < ActiveRecord::Migration[5.0]
  def change
    reversible do |idx|
      idx.up do
        execute <<-DDL.gsub /^\s+/, ''
          CREATE UNIQUE INDEX
            "index_compilation_releases_sorce_name_sorce_ident_type"
              ON "compilation_releases" (source_name, source_ident, type)
                WHERE "source_ident" IS NOT NULL;
        DDL
      end
      idx.down do
        remove_index :compilation_releases,
               name: :index_compilation_releases_sorce_name_sorce_ident_type
      end
    end
  end
end
