class PiecesForeignKeys < ActiveRecord::Migration
  def change
    add_foreign_key :pieces, :piece_heads, name: :pieces_fk_piece_heads
    add_foreign_key :pieces, :stations,    name: :pieces_fk_stations
  end
end
