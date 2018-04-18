class AddCodesToSeasons < ActiveRecord::Migration[5.2]
  def change
    add_column :seasons, :brainz_code, :uuid
    add_column :seasons, :discogs_code, :bigint
    add_column :seasons, :imdb_code, :bigint
    add_column :seasons, :tmdb_code, :bigint
    add_column :seasons, :wikidata_code, :bigint
  end
end
