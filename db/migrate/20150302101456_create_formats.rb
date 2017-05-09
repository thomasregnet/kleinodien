class CreateFormats < ActiveRecord::Migration[4.2]
  def change
    create_table :formats do |t|
      t.string :name, null: false
      t.string :abbr
      t.string :explanation

      t.timestamps null: false
    end
  end
end
