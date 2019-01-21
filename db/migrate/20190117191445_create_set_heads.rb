class CreateSetHeads < ActiveRecord::Migration[5.2]
  def change
    create_table :set_heads do |t|
      t.string :disambiguation
      t.string :title, null: false
      t.string :type
      t.uuid :brainz_code
      t.integer :imdb_code
      t.integer :tmdb_code
      t.integer :wikidata_code
      t.references :artist_credit, foreign_key: true
      t.references :import_order, foreign_key: true

      t.timestamps
    end
  end
end
