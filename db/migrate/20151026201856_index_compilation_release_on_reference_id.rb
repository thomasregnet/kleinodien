class IndexCompilationReleaseOnReferenceId < ActiveRecord::Migration[4.2]
  def change
    reversible do |idx|
      idx.up do
        execute <<-DDL.gsub /^\s+/, ''
          CREATE UNIQUE INDEX compilation_releases_reference_id
            ON compilation_releases (reference_id)
              WHERE reference_id IS NOT NULL;
        DDL
      end
      idx.down do
        remove_index(
          :compilation_releases,
          name: :compilation_releases_reference_id
        )
      end
    end
  end
end
