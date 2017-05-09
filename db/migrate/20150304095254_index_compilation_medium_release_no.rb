class IndexCompilationMediumReleaseNo < ActiveRecord::Migration[4.2]
  def change
    add_index(:compilation_media, [:compilation_release_id, :no], unique: true)
  end
end
