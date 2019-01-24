class RenamePieceReleaseIdToPieceId < ActiveRecord::Migration[5.2]
  def change
    rename_column :compilation_tracks, :piece_release_id, :piece_id
    rename_column :countries_piece_releases, :piece_release_id, :piece_id
    rename_column :descriptions, :piece_release_id, :piece_id
    rename_column :piece_releases_tags, :piece_release_id, :piece_id
    rename_column :pr_companies, :piece_release_id, :piece_id
    rename_column :pr_credits, :piece_release_id, :piece_id
    rename_column :pr_labels, :piece_release_id, :piece_id
    rename_column :ratings, :piece_release_id, :piece_id
    rename_column :repository_positions, :piece_release_id, :piece_id
  end
end
