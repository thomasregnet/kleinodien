class CreateImportOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :import_orders do |t|
      t.text :code, null: false
      t.text :kind, null: false
      t.text :state, null: false
      t.text :type, null: false
      t.text :uri
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
