class CountriesPieceHeads < ActiveRecord::Migration
  def change
    create_table :countries_piece_heads, id: false do |t|
      t.belongs_to :countries
      t.belongs_to :piece_heads
    end
  end
end
