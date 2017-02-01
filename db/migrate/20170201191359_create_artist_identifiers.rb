class CreateArtistIdentifiers < ActiveRecord::Migration[5.0]
  def change
    create_table :artist_identifiers do |t|
      t.references :source, foreign_key: true, null: false
      t.text :value, null: false

      t.timestamps
    end
  end
end
