class IndexCountriesPieceHeads < ActiveRecord::Migration
  def change
    add_index(
      :countries_piece_heads,
      [:country_id, :piece_head_id],
      unique: true
    )
  end
end
