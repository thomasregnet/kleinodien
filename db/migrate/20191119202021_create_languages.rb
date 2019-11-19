class CreateLanguages < ActiveRecord::Migration[6.0]
  def change
    create_table :languages do |t|
      t.string :name, null: false, unique: true
      t.string :iso_code_1, unique: true
      t.string :iso_code_2b, unique: true
      t.string :iso_code_2t, unique: true
      t.string :iso_code_3, unique: true

      t.timestamps
    end
  end
end
