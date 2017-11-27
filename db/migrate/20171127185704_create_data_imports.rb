class CreateDataImports < ActiveRecord::Migration[5.1]
  def change
    create_table :data_imports do |t|
      t.text :note, null: false

      t.timestamps
    end
  end
end
