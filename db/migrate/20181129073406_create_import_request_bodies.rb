class CreateImportRequestBodies < ActiveRecord::Migration[5.2]
  def change
    create_table :import_request_bodies do |t|
      t.text :content, null: false
      t.references :import_request, foreign_key: true, null: false

      t.datetime :created_at, null: false
    end
  end
end
