class CreatePieces < ActiveRecord::Migration[4.2]
  def change
    create_table :pieces do |t|
      t.integer :piece_head_id, null: false
      t.integer :station_id
      t.string :version
      t.string :type, null: false

      t.timestamps null: false
    end
  end
end
