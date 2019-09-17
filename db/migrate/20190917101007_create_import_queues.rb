class CreateImportQueues < ActiveRecord::Migration[6.0]
  def change
    create_table :import_queues do |t|
      t.text :about
      t.text :name, null: false, unique: true

      t.timestamps
    end
  end
end
