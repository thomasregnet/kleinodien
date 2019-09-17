class RenameHeapMediaToReleaseMedia < ActiveRecord::Migration[6.0]
  def change
    rename_table :heap_media, :release_media
  end
end
