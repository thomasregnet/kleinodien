class RemoveHeapTracksHeapId < ActiveRecord::Migration[5.2]
  def change
    remove_column :heap_tracks, :heap_id
    add_reference :heap_tracks, :heap_subset, foreign_key: true, null: false
  end
end
