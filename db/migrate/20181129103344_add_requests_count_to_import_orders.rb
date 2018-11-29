class AddRequestsCountToImportOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :import_orders, :requests_count, :integer
  end
end
