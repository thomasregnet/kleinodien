class IndexCompilationReleasesOnCompilationHeadId < ActiveRecord::Migration[4.2]
  def change
    add_index(:compilation_releases, :compilation_head_id, unique: true)
  end
end
