class AddImportQueuesToImportOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :import_orders, :kind
    add_reference :import_orders, :import_queue, foreign_key: true
  end
end
