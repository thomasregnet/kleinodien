class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.integer :serial_id, null: false
      t.integer :no,        null: false
      t.string :title

      t.timestamps null: false
    end
  end
end
