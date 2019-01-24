class RenamePieceReleaseCountriesToPieceCountries < ActiveRecord::Migration[5.2]
  def change
    rename_table :countries_piece_releases, :countries_pieces
  end
end
