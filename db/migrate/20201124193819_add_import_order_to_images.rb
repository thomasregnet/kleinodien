class AddImportOrderToImages < ActiveRecord::Migration[6.0]
  def change
    add_reference :images, :import_order, foreign_key: true
  end
end
