class AddIndicesToPieceHeads < ActiveRecord::Migration[4.2]
  def change
    add_index :piece_heads, :artist_credit_id
    add_index :piece_heads, :season_id
  end
end
