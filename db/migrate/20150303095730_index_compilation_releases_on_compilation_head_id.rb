class IndexCompilationReleasesOnCompilationHeadId < ActiveRecord::Migration
  def change
    add_index(:compilation_releases, :compilation_head_id, unique: true)
  end
end
