class AddCodesToPieceHeads < ActiveRecord::Migration[5.2]
  def change
    add_column :piece_heads, :brainz_code, :uuid
    add_column :piece_heads, :discogs_code, :bigint
    add_column :piece_heads, :imdb_code, :bigint
    add_column :piece_heads, :tmdb_code, :bigint
    add_column :piece_heads, :wikidata_code, :bigint
  end
end
