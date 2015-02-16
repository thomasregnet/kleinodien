class CreatePieceHeads < ActiveRecord::Migration
  def change
    create_table :piece_heads do |t|
      t.integer :artist_credit_id
      t.integer :season_id
      t.string :title, null: false
      t.string :disambiguation
      t.integer :no
      t.string :type, null: false

      t.timestamps null: false
    end
  end
end
