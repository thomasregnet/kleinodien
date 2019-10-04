class RenamePieceTracksPieceReleaseIdToPieceId < ActiveRecord::Migration[6.0]
  def change
    rename_column :piece_tracks, :piece_release_id, :piece_id
  end
end
