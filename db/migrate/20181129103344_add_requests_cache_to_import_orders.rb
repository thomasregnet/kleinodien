class AddRequestsCacheToImportOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :import_orders, :requests_cache, :integer
  end
end
