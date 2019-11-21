class CreateScripts < ActiveRecord::Migration[6.0]
  def change
    create_table :scripts do |t|
      t.string :name, null: false
      t.string :iso_code, null: false
      t.column :iso_number, 'smallint'

      t.timestamps
    end
  end
end
