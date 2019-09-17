class RenameHeapSubsetsToReleaseSubsets < ActiveRecord::Migration[6.0]
  def change
    rename_table :heap_subsets, :release_subsets

    rename_column :heap_tracks, :heap_subset_id, :release_subset_id
  end
end
