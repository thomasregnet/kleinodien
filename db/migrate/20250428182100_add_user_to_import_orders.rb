class AddUserToImportOrders < ActiveRecord::Migration[8.0]
  def change
    add_reference :import_orders, :user, null: false, foreign_key: true, type: :uuid
  end
end
