class RenameTracksToCompilationTracks < ActiveRecord::Migration[5.0]
  def change
    reversible do |rename|
      rename.up do
        rename_table :tracks, :compilation_tracks
      end
      rename.down do
        rename_table :compilation_tracks, :tracks
      end
    end
  end
end
