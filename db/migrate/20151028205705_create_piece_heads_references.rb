class CreatePieceHeadsReferences < ActiveRecord::Migration[4.2]
  def change
    create_table :piece_heads_references, id: false do |t|
      t.references :piece_head, index: true, foreign_key: true
      t.references :reference, index: true, foreign_key: true
    end
  end
end
