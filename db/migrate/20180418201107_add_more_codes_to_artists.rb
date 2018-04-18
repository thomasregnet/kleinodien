class AddMoreCodesToArtists < ActiveRecord::Migration[5.2]
  def change
    add_column :artists, :imdb_code, :bigint
    add_column :artists, :tmdb_code, :bigint
  end
end
