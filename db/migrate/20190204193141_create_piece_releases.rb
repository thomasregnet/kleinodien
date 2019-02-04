class CreatePieceReleases < ActiveRecord::Migration[5.2]
  def change
    create_table :piece_releases do |t|
      t.string :position
      t.references :heap, foreign_key: true
      t.references :import_order, foreign_key: true
      t.references :piece, foreign_key: true, null: false

      t.timestamps
    end
  end
end
