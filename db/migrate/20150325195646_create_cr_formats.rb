class CreateCrFormats < ActiveRecord::Migration[4.2]
  def change
    create_table :cr_formats do |t|
      t.integer :compilation_release_id, null: false
      t.integer :format_kind_id,         null: false
      t.integer :quantity,               null: false
      t.integer :no,                     null: false

      t.timestamps null: false
    end
  end
end
