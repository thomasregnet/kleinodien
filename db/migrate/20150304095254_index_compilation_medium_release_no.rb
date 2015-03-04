class IndexCompilationMediumReleaseNo < ActiveRecord::Migration
  def change
    add_index(:compilation_media, [:compilation_release_id, :no], unique: true)
  end
end
