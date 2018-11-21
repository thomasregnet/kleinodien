class CreateImportAttempts < ActiveRecord::Migration[5.2]
  def change
    create_table :import_attempts do |t|
      t.text :message
      t.integer :status_code, limit: 2, null: false
      t.references :import_request, foreign_key: true, null: false


      # Rows in this table will not be updated so we don't need :updated_at.
      # t.timestamps
      t.datetime :created_at, null: false
    end
  end
end
