class RenameSomeIndxesOnPieceReleases < ActiveRecord::Migration[4.2]
  def change
    rename_index :piece_releases,
                 :index_piece_on_piece_head_id_and_lower_version,
                 :index_piece_releases_on_piece_head_id_and_lower_version
    rename_index :piece_releases,
                 :index_piece_on_unique_piece_head_id,
                 :index_piece_releases_on_unique_piece_head_id
  end
end
