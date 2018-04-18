class AddCodesToSerials < ActiveRecord::Migration[5.2]
  def change
    add_column :serials, :brainz_code, :uuid
    add_column :serials, :discogs_code, :bigint
    add_column :serials, :imdb_code, :bigint
    add_column :serials, :tmdb_code, :bigint
    add_column :serials, :wikidata_code, :bigint
  end
end
