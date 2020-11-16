class AddParentToImportOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :import_orders, :import_order, foreign_key: true, index: true
  end
end
