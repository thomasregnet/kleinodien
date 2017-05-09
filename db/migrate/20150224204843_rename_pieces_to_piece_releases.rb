class RenamePiecesToPieceReleases < ActiveRecord::Migration[4.2]
  def change
    rename_table :pieces, :piece_releases
  end
end
