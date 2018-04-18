class AddMoreCodesToCompilationHeads < ActiveRecord::Migration[5.2]
  def change
    add_column :compilation_heads, :imdb_code, :bigint
    add_column :compilation_heads, :tmdb_code, :bigint
  end
end
