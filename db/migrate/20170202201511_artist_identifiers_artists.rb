class ArtistIdentifiersArtists < ActiveRecord::Migration[5.0]
  def change
    create_table :artist_identifiers_artists, id: false do |t|
      t.references :artist_identifier, foreign_key: true, null: false
      t.references :artist,            foreign_key: true, null: false
    end
  end
end
