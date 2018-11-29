class CreateImportRequestBodies < ActiveRecord::Migration[5.2]
  def change
    create_table :import_request_bodies do |t|
      t.text :content
      t.references :import_request, foreign_key: true

      t.timestamps
    end
  end
end
