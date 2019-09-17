class RenameHeapTracksToReleaseTracks < ActiveRecord::Migration[6.0]
  def change
    rename_table :heap_tracks, :release_tracks
  end
end
