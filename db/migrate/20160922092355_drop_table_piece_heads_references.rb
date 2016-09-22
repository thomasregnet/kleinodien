class DropTablePieceHeadsReferences < ActiveRecord::Migration[5.0]
  def change
    drop_table :piece_heads_references
  end
end
