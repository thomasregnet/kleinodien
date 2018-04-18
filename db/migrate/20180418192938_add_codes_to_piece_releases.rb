class AddCodesToPieceReleases < ActiveRecord::Migration[5.2]
  def change
    add_column :piece_releases, :brainz_code, :uuid
    add_column :piece_releases, :discogs_code, :bigint
    add_column :piece_releases, :imdb_code, :bigint
    add_column :piece_releases, :tmdb_code, :bigint
    add_column :piece_releases, :wikidata_code, :bigint
  end
end
