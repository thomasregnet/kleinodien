class AddReferenceToPieceHead < ActiveRecord::Migration
  def change
    add_reference :piece_heads, :reference, index: true, foreign_key: true
  end
end
