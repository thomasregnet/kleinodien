class AddImportOrderToPieceHeads < ActiveRecord::Migration[5.2]
  def change
    add_reference :piece_heads, :import_order, foreign_key: true
  end
end
