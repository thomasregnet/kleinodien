class CreateHeaps < ActiveRecord::Migration[5.2]
  def change
    create_table :heaps do |t|
      t.integer :barcode
      t.date :date
      t.integer :data_mask
      t.string :title
      t.string :type
      t.string :version
      t.uuid :brainz_code
      t.integer :discogs_code
      t.integer :imdb_code
      t.integer :tmdb_code
      t.integer :wikidata_code
      t.references :artist_credit, foreign_key: true
      t.references :import_order, foreign_key: true
      t.references :heap_head, foreign_key: true, null: false

      t.timestamps
    end
  end
end
