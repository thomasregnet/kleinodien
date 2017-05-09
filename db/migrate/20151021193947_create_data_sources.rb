class CreateDataSources < ActiveRecord::Migration[4.2]
  def change
    create_table :data_sources do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
