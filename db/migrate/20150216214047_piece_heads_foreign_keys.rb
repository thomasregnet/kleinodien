class PieceHeadsForeignKeys < ActiveRecord::Migration[4.2]
  def change
    add_foreign_key :piece_heads, :artist_credits,
                    name: :piece_heads_fk_artist_credits
    add_foreign_key :piece_heads, :seasons, name: :piece_heads_fk_seasons
  end
end
