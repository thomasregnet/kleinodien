class CreateSerials < ActiveRecord::Migration
  def change
    create_table :serials do |t|
      t.string :title, null: false
      t.string :disambiguation

      t.timestamps null: false
    end
  end
end
