class DropHabtmCountriesTables < ActiveRecord::Migration[6.0]
  def change
    drop_table :countries_piece_heads
    drop_table :countries_pieces
  end
end
