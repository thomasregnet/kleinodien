class CreateTracks < ActiveRecord::Migration[4.2]
  def change
    create_table :tracks do |t|
      t.integer :piece_release_id, null: false
      t.integer :format_id,        null: false
      t.integer :no
      t.string :path

      t.timestamps null: false
    end
  end
end
