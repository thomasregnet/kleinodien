class RenamePieceReleasesToPieces < ActiveRecord::Migration[5.2]
  def change
    rename_table :piece_releases, :pieces
  end
end
