class CreateCrFormats < ActiveRecord::Migration
  def change
    create_table :cr_formats do |t|
      t.integer :compilation_release_id
      t.integer :format_kind_id
      t.integer :quantity
      t.integer :no

      t.timestamps null: false
    end
  end
end
