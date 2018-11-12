class CreateImportRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :import_requests do |t|
      t.integer :attempts_cache, null: false, default: 0
      t.text :code, null: false
      t.text :state, null: false, default: :pending
      t.text :type, null: false
      t.references :import_order, foreign_key: true, null: false

      t.timestamps
    end
  end
end
