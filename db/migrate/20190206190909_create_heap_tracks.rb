class CreateHeapTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :heap_tracks do |t|
      t.string :accuracy
      t.integer :milliseconds
      t.string :position, null: false
      t.uuid :brainz_code
      t.references :heap, foreign_key: true, null: false
      t.references :import_order, foreign_key: true
      t.references :piece, foreign_key: true, null: false

      t.timestamps
    end
  end
end
