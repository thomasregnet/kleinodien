class CreateCompilationIdentifiers < ActiveRecord::Migration[4.2]
  def change
    create_table :compilation_identifiers do |t|
      t.integer :compilation_release_id, null: false
      t.integer :identifier_type_id,     null: false
      t.string :code,                    null: false
      t.string :disambiguation

      t.timestamps null: false
    end
  end
end
