class CreatePieceTracks < ActiveRecord::Migration[5.0]
  def change
    create_table :piece_tracks do |t|
      t.references :piece_release, foreign_key: true, null: false
      t.references :tr_format_kind, foreign_key: true
      t.integer :milliseconds
      t.text :accuracy

      t.timestamps
    end
  end
end
