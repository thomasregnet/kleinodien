class CreateStations < ActiveRecord::Migration[4.2]
  def change
    create_table :stations do |t|
      t.string :name, null: false
      t.string :disambiguation
      t.string :type, null: false

      t.timestamps null: false
    end
  end
end
