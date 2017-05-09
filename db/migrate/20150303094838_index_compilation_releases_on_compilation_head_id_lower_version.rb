class IndexCompilationReleasesOnCompilationHeadIdLowerVersion < ActiveRecord::Migration[4.2]
  def change
    reversible do |idx|
      idx.up do
        execute <<-DDL
          CREATE UNIQUE INDEX
            index_compilation_releases_on_compilation_head_id_lower_version
              ON compilation_releases (compilation_head_id, LOWER(version));
        DDL
      end
      idx.down do
        remove_index(
          :compilation_releases,
          name: :index_compilation_releases_on_compilation_head_id_lower_version
        )
      end
    end
  end
end
