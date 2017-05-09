class IndexCountriesPieceHeads < ActiveRecord::Migration[4.2]
  def change
    add_index(
      :countries_piece_heads,
      [:country_id, :piece_head_id],
      unique: true
    )
  end
end
