class AddCodesToCompilationReleases < ActiveRecord::Migration[5.2]
  def change
    add_column :compilation_releases, :discogs_code, :bigint
    add_column :compilation_releases, :imdb_code, :bigint
    add_column :compilation_releases, :tmdb_code, :bigint
    add_column :compilation_releases, :wikidata_code, :bigint
  end
end
