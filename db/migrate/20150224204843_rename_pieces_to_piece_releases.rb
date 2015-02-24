class RenamePiecesToPieceReleases < ActiveRecord::Migration
  def change
    rename_table :pieces, :piece_releases
  end
end
