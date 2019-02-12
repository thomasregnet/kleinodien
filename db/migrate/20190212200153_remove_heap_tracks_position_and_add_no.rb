class RemoveHeapTracksPositionAndAddNo < ActiveRecord::Migration[5.2]
  def change
    remove_column :heap_tracks, :position
    add_column :heap_tracks, :no, :smallint, null: false
  end
end
