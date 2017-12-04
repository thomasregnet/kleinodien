class DiscogsCodeAndWikidataCodeForArtists < ActiveRecord::Migration[5.1]
  def change
    add_column :artists, :discogs_code, :bigint
    add_column :artists, :wikidata_code, :bigint

    add_index :artists,
              :discogs_code,
              unique: true,
              name: :index_on_artists_discogs_code

    add_index :artists,
              :wikidata_code,
              unique: true,
              name: :index_on_artists_wikidata_code
  end
end
