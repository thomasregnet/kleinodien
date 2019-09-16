class RenameHeapsToReleases < ActiveRecord::Migration[6.0]
  def change
    rename_table :heaps, :releases

    rename_column :heap_media, :heap_id, :release_id
    rename_column :heap_subsets, :heap_id, :release_id
  end
end
