class CreateCountriesPieceHeads < ActiveRecord::Migration[4.2]
  def change
    create_table :countries_piece_heads do |t|
      t.references :country, index: true, foreign_key: true, null: false
      t.references :piece_head, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
