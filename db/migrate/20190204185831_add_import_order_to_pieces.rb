class AddImportOrderToPieces < ActiveRecord::Migration[5.2]
  def change
    add_reference :pieces, :import_order, foreign_key: true
  end
end
